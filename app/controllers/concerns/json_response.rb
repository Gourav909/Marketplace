class JsonResponse
  attr_reader :success, :data, :meta, :errors, :message

  def initialize(options = {})
    @success = options[:success].to_s.empty? ? true : options[:success]
    @message = options[:message] || ''
    @data = options[:data] || []
    @meta = options[:meta] || []
    @errors = options[:errors] || []
  end

  def as_json(*)
    {
      success: success,
      data: data,
      meta: meta,
      errors: []
    }
  end
end
