require_relative '../test_helper'
require_relative 'util_test_constants'

class BaseUtilTest < ActiveSupport::TestCase
  include UtilTestConstants

  def mock_response_object
    ::ActionDispatch::Response.new
  end
end
