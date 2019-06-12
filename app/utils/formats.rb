module Formats
  def self.date_format
    'YYYY-MM-DD'
  end

  def boolean?(parameter)
    expected_format_path = 'data_formats.boolean'

    is_boolean = parameter.is_a?(TrueClass) || parameter.is_a?(FalseClass) ||
        parameter == 1 || parameter == 0 ||
        (parameter.is_a?(String) && parameter.casecmp('false') != -1) ||
        (parameter.is_a?(String) && parameter.casecmp('true') != -1)

    [is_boolean, expected_format_path]
  end

  def date?(parameter, format = '%Y-%m-%d')
    expected_format_path = 'data_formats.date'

    begin
      is_valid = parameter.match(/\d{4}-\d{2}-\d{2}/) && Date.strptime(parameter, format)
    rescue StandardError
      is_valid = false
    end

    [is_valid, expected_format_path]
  end

  def string?(parameter)
    expected_format_path = 'data_formats.string'

    [parameter.is_a?(String), expected_format_path]
  end

  def number?(parameter)
    expected_format_path = 'data_formats.number'
    is_numeric = (parameter.is_a?(Numeric) || /\A[+-]?\d+([,.]\d+)?\z/ =~ parameter).present?
    [is_numeric, expected_format_path]
  end

  def positive_number?(parameter)
    expected_format_path = 'data_formats.positive_number'
    is_positive_number = number?(parameter)[0] && parameter.to_f > 0

    [is_positive_number, expected_format_path]
  end

  def integer?(parameter)
    expected_format_path = 'data_formats.integer'
    is_integer = parameter.is_a?(Integer) || parameter.to_i.to_s == parameter

    [is_integer, expected_format_path]
  end

  def hash?(parameter)
    expected_format_path = 'data_formats.hash'
    is_hash = parameter.is_a?(Hash)

    [is_hash, expected_format_path]
  end

  def email?(parameter)
    expected_format_path = 'data_formats.email'
    is_email = parameter.is_a?(String) && parameter =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    [is_email, expected_format_path]
  end

end
