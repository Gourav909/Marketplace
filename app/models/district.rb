class District < ApplicationRecord
  self.table_name = :districts
  belongs_to :city
end
