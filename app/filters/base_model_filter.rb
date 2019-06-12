class BaseModelFilter

  include Formats

  def initialize(resources, filter_params)
    @resources = resources
    @filter_params = filter_params
  end

  def filter
    perform_filtering
    @resources
  end

  def id_filter(*associations)
    associations.each do |association|
      id = extract_id association, @filter_params
      @resources = @resources.where(association => id) if id.present?
    end

    @resources
  end

  def numeric_filter(*numeric_fields)
    numeric_fields.each do |numeric_field|
      if @filter_params.key?(numeric_field)
        numeric_value = @filter_params[numeric_field]
        @resources = @resources.where(numeric_field => numeric_value) if _number?(numeric_value)
      end
      if @filter_params.key?("#{numeric_field}_gt".to_sym)
        numeric_value = @filter_params["#{numeric_field}_gt".to_sym]
        @resources = @resources.where("#{numeric_field} > ?", numeric_value) if _number?(numeric_value)
      end
      if @filter_params.key?("#{numeric_field}_gte".to_sym)
        numeric_value = @filter_params["#{numeric_field}_gte".to_sym]
        @resources = @resources.where("#{numeric_field} >= ?", numeric_value) if _number?(numeric_value)
      end
      if @filter_params.key?("#{numeric_field}_lte".to_sym)
        numeric_value = @filter_params["#{numeric_field}_lte".to_sym]
        @resources = @resources.where("#{numeric_field} <= ?", numeric_value) if _number?(numeric_value)
      end
      if @filter_params.key?("#{numeric_field}_lt".to_sym)
        numeric_value = @filter_params["#{numeric_field}_lt".to_sym]
        @resources = @resources.where("#{numeric_field} < ?", numeric_value) if _number?(numeric_value)
      end
    end

    @resources
  end

  def date_filter(*date_fields)
    date_fields.each do |date_field|
      if @filter_params.key?(date_field)
        date_value = @filter_params[date_field]
        if _date? date_value
          day_interval = day_interval date_value
          @resources = @resources.where(date_field => day_interval)
        end
      end
      if @filter_params.key?("#{date_field}_gt".to_sym)
        date_value = @filter_params["#{date_field}_gt".to_sym]
        if _date? date_value
          parsed_date = Time.parse(date_value).end_of_day
          @resources = @resources.where("#{date_field} > ?", "%#{parsed_date}")
        end
      end
      if @filter_params.key?("#{date_field}_gte".to_sym)
        date_value = @filter_params["#{date_field}_gte".to_sym]
        if _date? date_value
          parsed_date = Time.parse(date_value).beginning_of_day
          @resources = @resources.where("#{date_field} >= ?", "%#{parsed_date}")
        end
      end
      if @filter_params.key?("#{date_field}_lte".to_sym)
        date_value = @filter_params["#{date_field}_lte".to_sym]
        if _date? date_value
          parsed_date = Time.parse(date_value).end_of_day
          @resources = @resources.where("#{date_field} <= ?", "%#{parsed_date}")
        end
      end
      if @filter_params.key?("#{date_field}_lt".to_sym)
        date_value = @filter_params["#{date_field}_lt".to_sym]
        if _date? date_value
          parsed_date = Time.parse(date_value).beginning_of_day
          @resources = @resources.where("#{date_field} < ?", "%#{parsed_date}")
        end
      end
    end

    @resources
  end

  def enum_filter(*enum_fields) # TODO: Sanitize non-parseable values such as " wrapped stuff
    enum_fields.each do |enum_field|
      @resources = @resources.where(enum_field => @filter_params[enum_field]) if @filter_params.key?(enum_field)
    end

    @resources
  end

  def text_filter(*text_fields)
    text_fields.each do |text_field|
      if @filter_params.key?(text_field)
        @resources = @resources.where(text_field => @filter_params[text_field])
      elsif @filter_params.key?("#{text_field}_contains".to_sym)
        field_value = @filter_params["#{text_field}_contains".to_sym]
        @resources = @resources.where("#{text_field} ilike ?", "%#{field_value}%")
      end
    end

    @resources
  end

  def extract_param(key)
    parameter = @filter_params[key]
    parameter = nil if parameter == 'null'
    parameter
  end

  protected

  def perform_filtering
    raise NotImplementedError
  end

  def extract_id(symbol, parameters)
    parameters[symbol] || parameters["#{symbol}_id".to_sym] || parameters["id_#{symbol}".to_sym]
  end

  def _number?(numeric_value)
    number?(numeric_value)[0]
  end

  def _date?(date_value)
    date?(date_value)[0]
  end

  def day_interval(date_value)
    TimeUtils.day_interval date_value
  end
end
