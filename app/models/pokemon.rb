class Pokemon < ApplicationRecord
  require 'csv'

  #pagination
  paginates_per 10

  # validations
  validates :name,  :height, :weight, presence: true
  validates :name,  uniqueness: true

  # scope
  default_scope {order("created_at desc")}

  class << self

    def initialize_pokemon(pokemon)
      new({
        name:   pokemon["identifier"],
        height: pokemon["height"],
        weight: pokemon["weight"]
      })
    end
  end

end
