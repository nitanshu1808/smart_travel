class PokemonAddWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  def perform(csv_path)
    CSV.foreach((csv_path), headers: true) do |pokemon|
      pokemon = Pokemon.initialize_pokemon(pokemon)
        unless pokemon.save
          puts "#{pokemon.errors.full_messages.first}"
        end
    end
  end
end
