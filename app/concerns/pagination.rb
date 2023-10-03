module Pagination
  extend ActiveSupport::Concern
  def page_meta(object, meta = {})
    if object.respond_to?(:current_page)
      per_page = params[:per].to_i
      per_page = 20 if per_page.zero?
      meta[:pagination] = {
        per_page: per_page.to_i,
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.prev_page,
        total_pages: object.total_pages,
        total_count: object.total_count
      }
    end
    meta
  end

  def paginatable_array(data)
    Kaminari.paginate_array(data).page(params[:page] || 1).per(params[:per] || 20)
  end

  def searilzer(serializer_name, paginated_properties)
    ActiveModel::Serializer::CollectionSerializer.new(
      paginated_properties,
      user: current_user,
      serializer: serializer_name
    )
  end
end
