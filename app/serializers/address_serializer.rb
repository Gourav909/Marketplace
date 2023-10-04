class AddressSerializer < ActiveModel::Serializer
   attributes :id, :city_name, :district_name, :city_id, :district_id
end
