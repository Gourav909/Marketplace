class FavouriteProperty < ApplicationRecord
  self.table_name = :favourite_properties
  paginates_per 10

  belongs_to :user
  belongs_to :property

  validates :user_id, uniqueness: { scope: :property_id }
end
