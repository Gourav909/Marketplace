class Address < ApplicationRecord
  self.table_name = :addresses
  belongs_to :property
  belongs_to :city
  belongs_to :district
end
