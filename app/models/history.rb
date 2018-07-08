class History < ApplicationRecord
  #validations
  validates :stop_name, :stop_id, :history_type, :user_id, presence: true
  validates_uniqueness_of :stop_name, scope: :stop_id,
    message: I18n.t("web.duplicate_record")
  #associations
  belongs_to :user
end
