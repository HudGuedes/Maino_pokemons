class Pokemon::Api
  BASE_URL = 'https://pokeapi.co/api/v2'
  class << self
    def pokemons
      response = RestClient.get("#{BASE_URL}/pokemon?limit=1118&offset=0", headers={})
      JSON.parse(response.body)['results']
    end

    def pokemon(name)
      response = RestClient.get("#{BASE_URL}/pokemon/#{name}", headers={})
      JSON.parse(response.body)
    end
  end
end