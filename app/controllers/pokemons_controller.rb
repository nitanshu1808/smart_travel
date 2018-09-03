class PokemonsController < ApplicationController

  def index
    @pokemons = Pokemon.page( params[:page])
  end

  def upload
    csv_path = params["file"].path() #csv file path
    PokemonAddWorker.perform_async(csv_path)
    redirect_to pokemons_path, :flash => { :notice => I18n.t("web.record_created") }
  end

  def destroy_all
  	PokemonRemoveWorker.perform_async
  	redirect_to pokemons_path, :flash => { :error => I18n.t("web.record_deleted") }
  end
end
