class AddressSerializer < ActiveModel::Serializer
   attributes :id
   attribute :city_name do |object|
      @object.city.name
   end
   attribute :district_name do |object|
      @object.district.district_name
   end
end
