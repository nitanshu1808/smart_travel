class CreateProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :providers do |t|
    	t.string  :provider, null: false
    	t.string  :provider_uid, null: false
    	t.integer :user_id
      t.timestamps
    end
  end
end
