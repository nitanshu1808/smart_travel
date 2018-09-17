class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
    	t.text :content, null: false, default: ""
      t.timestamps
    end
  end
end
