require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:///pokedex.db'

class Pokemon < ActiveRecord::Base
end

helpers do
  def post_show_page?
    request.path_info =~ /\/pokemons\/\d+$/
  end

  def delete_post_button(pokemon_id)
    erb :_delete_post_button, locals: {pokemon_id: pokemon_id}
  end
end

# Get all of our routes
get "/" do
  @pokemons = Pokemon.order("created_at DESC")
  
  erb :"pokemons/index"
end

# Get the New Pokemon form
get "/pokemons/new" do
  @title = "New Pokemon"
  @pokemon = Pokemon.new
  erb :"pokemons/new"
end

# The New Pokemon form sends a POST request (storing data) here
# where we try to create the post it sent in its params hash.
# If successful, redirect to that post. Otherwise, render the "pokemons/new"
# template where the @post object will have the incomplete data that the 
# user can modify and resubmit.
post "/pokemons" do
  @post = Pokemon.new(params[:pokemon])
  if @post.save
    redirect "pokemons/#{@post.id}"
  else
    erb :"pokemons/new"
  end
end

# Get the individual page of the post with this ID.
get "/pokemons/:id" do
  @pokemon = Pokemon.find(params[:id])
  @title = @pokemon.name
  erb :"pokemons/show"
end

# Get the Edit Pokemon form of the post with this ID.
get "/pokemons/:id/edit" do
  @pokemon = Pokemon.find(params[:id])
  @title = "Edit Form"
  erb :"pokemons/edit"
end

# The Edit Pokemon form sends a PUT request (modifying data) here.
# If the post is updated successfully, redirect to it. Otherwise,
# render the edit form again with the failed @post object still in memory
# so they can retry.
put "/pokemons/:id" do
  @post = Pokemon.find(params[:id])
  if @post.update_attributes(params[:pokemon])
    redirect "/pokemons/#{@post.id}"
  else
    erb :"pokemons/edit"
  end
end

# Deletes the post with this ID and redirects to homepage.
delete "/pokemons/:id" do
  @post = Pokemon.find(params[:id]).destroy
  redirect "/"
end
