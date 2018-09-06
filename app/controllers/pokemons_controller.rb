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
  	redirect_to pokemons_path, :flash => { :notice => I18n.t("web.record_deleted") }
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      @pokemons = Pokemon.page( params[:page])
    end
  end

  def destroy
    @pokemon = Pokemon.find_by(id: params["id"])
    @pokemon.destroy
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :height, :weight)
  end

end
