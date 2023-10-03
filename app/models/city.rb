class City < ApplicationRecord
  self.table_name = :cities
  has_many :districts
end
