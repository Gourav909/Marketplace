class Property < ApplicationRecord
  self.table_name = :properties
  include Filterable
  paginates_per 10

  belongs_to :user
  has_one :address, dependent: :destroy
  has_one_attached :image

  enum property_type: { residential: 'residential', office: 'office', retail: 'retail', home: 'home' }

  accepts_nested_attributes_for :address, allow_destroy: true
  validates :title, presence: true

  scope :filter_by_property_type, -> (type) { where property_type: type }
  scope :filter_by_city, -> (city_id) { where(address: { city_id: city_id}) }
  scope :filter_by_district, -> (district_ids) { where(address: { district_id: district_ids})
  }
  scope :filter_by_net_size, ->(val) { where(net_size: val[0]..val[1]) }
  scope :filter_by_rent_per_month, ->(val) { where(price_per_month: val[0]..val[1]) }

  def self.search(val)
    return all if val.blank?
    search_params = { search: "%#{val}%" }

    query = Property.joins(address: { city: :districts })
    .where(
      'cities.name LIKE :search OR ' \
      'districts.name LIKE :search OR ' \
      'property_type LIKE :search OR ' \
      'net_size LIKE :search OR ' \
      'price_per_month LIKE :search OR ' \
      'mrt_line LIKE :search OR ' \
      'title LIKE :search OR ' \
      'no_of_rooms LIKE :search',
      search_params
      ).distinct
  end
end
