class CreatePokemon < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :species
      t.text :sprite
      t.references :team

      t.timestamps
    end
  end
end
