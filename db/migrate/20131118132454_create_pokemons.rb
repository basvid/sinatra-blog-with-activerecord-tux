class CreatePokemons < ActiveRecord::Migration
  def up
    create_table :pokemons do |t|
      t.string :name
      t.string :element
      t.integer :level
      t.boolean :sex
      t.timestamps
    end
  end

  def down
    drop_table :pokemons
  end
end
