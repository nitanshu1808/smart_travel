class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
    	t.string :stop_name, null: false
    	t.string :stop_id    	
      t.timestamps
    end
  end
end
