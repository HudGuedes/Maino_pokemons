class PokemonsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @pokemons = Pokemon::Api.pokemons
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def create
    team = Team.find(params[:team_id])
    return redirect_to team_path(params[:team_id]), alert: 'Time já possui 6 pokemons' if team.full_member?
    errors = []
    params[:names].each do |name|
      pokemon = Pokemon::Api.pokemon(name)
      species = pokemon['types'].map{|x| x['type']['name'] }.join(', ')
      item = Pokemon.create(
        name: pokemon['name'],
        species: species, 
        sprite: pokemon['sprites']['other']['official-artwork']['front_default'],
        team_id: params[:team_id]
      )
      errors << { name: name, errors: item.errors.full_messages.to_sentence } if item.errors.present?
    end
    if errors.present?
      error_message = 'Os seguintes pokemons não puderam ser criados: '
      errors.each do |error|
        error_message += "#{error[:name]} - #{error[:errors]} | "
      end
      return redirect_to team_path(params[:team_id]), alert: error_message
    end
    redirect_to team_path(params[:team_id]), notice: 'Pokemon(s) criado(s) com sucesso!'
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    team_id = @pokemon.team.id
    @pokemon.destroy
    redirect_to team_path(team_id), notice: 'Pokemon deletado com sucesso!'
  end
end
