class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
    	t.string 		:name
    	t.string 		:height
    	t.string    :weight  
      t.timestamps
    end
  end
end
