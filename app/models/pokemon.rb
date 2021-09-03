class Pokemon < ApplicationRecord
  belongs_to :team
  validate :limit_pokemon

  def limit_pokemon
    errors.add(:base, "limite maximo de 6 pokemos") if team.full_member?
  end
end
