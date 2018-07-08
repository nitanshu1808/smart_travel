class AddSearchTypeToHistory < ActiveRecord::Migration[5.2]
  def change
  	add_column   :histories, :history_type, :string, default: "bus", null: false
  	add_column   :histories, :user_id, :integer
  end
end
