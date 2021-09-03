class Team < ApplicationRecord
  has_many :pokemons
  belongs_to :user

  def full_member?
    pokemons.count >= 6
  end
end
