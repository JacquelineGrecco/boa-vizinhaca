require_relative 'base_util_test'

class FormatsTest < BaseUtilTest

  include Formats

  def assert_parseable(values, format_checker)
    values.each do |value|
      is_valid, _expected_format_path = format_checker.call(value)

      assert is_valid, value
    end
  end

  def assert_not_parseable(values, format_checker, expected_format)
    values.each do |value|
      is_valid, expected_format_path = format_checker.call(value)

      assert_not is_valid, value
      assert_equal expected_format, expected_format_path
    end
  end


  test 'returns no error for valid dates' do
    assert_parseable VALID_DATES, method(:date?)
  end

  test 'returns an error for invalid dates' do
    assert_not_parseable INVALID_DATES, method(:date?), EXPECTED_DATE_FORMAT
  end

  test 'returns no error for valid strings' do
    assert_parseable VALID_STRINGS, method(:string?)
  end

  test 'returns an error for invalid strings' do
    assert_not_parseable INVALID_STRINGS, method(:string?), EXPECTED_STRING_FORMAT
  end

  test 'returns no error for valid numbers' do
    parseable_numbers = VALID_NUMBERS + VALID_NUMBERS.map(&:to_s) + NEGATIVE_NUMBERS + POSITIVE_NUMBERS + POSITIVE_INTEGERS

    assert_parseable parseable_numbers, method(:number?)
  end

  test 'returns an error for invalid numbers' do
    assert_not_parseable INVALID_NUMBERS, method(:number?), EXPECTED_NUMBER_FORMAT
  end

  test 'returns no error for positive numbers' do
    positive_numbers = POSITIVE_NUMBERS

    assert_parseable positive_numbers, method(:positive_number?)
  end

  test 'returns an error for non positive numbers' do
    non_positive = [ZERO, NEGATIVE_NUMBERS, NEGATIVE_NUMBERS.map(&:to_s)].flatten

    assert_not_parseable non_positive, method(:positive_number?), EXPECTED_POSITIVE_NUMBER_FORMAT
  end

  test 'returns no error for parseable integers' do
    parseable_integers = VALID_INTEGERS + VALID_INTEGERS.map { |i| i.to_s }

    assert_parseable parseable_integers, method(:integer?)
  end

  test 'returns an error for invalid integers' do
    assert_not_parseable INVALID_INTEGERS, method(:integer?), EXPECTED_INTEGER_FORMAT
  end

  test 'returns no error for parseable booleans' do
    parseable_booleans = VALID_BOOLEANS

    assert_parseable parseable_booleans, method(:boolean?)
  end

  test 'returns an error for invalid booleans' do
    assert_not_parseable INVALID_BOOLEANS, method(:boolean?), EXPECTED_BOOLEAN_FORMAT
  end

  test 'returns no error for parseable hashes' do
    parseable_hashes = VALID_HASHES

    assert_parseable parseable_hashes, method(:hash?)
  end

  test 'returns an error for invalid hashes' do
    assert_not_parseable INVALID_HASHES, method(:hash?), EXPECTED_HASH_FORMAT
  end

  test 'returns no error for parseable emails' do
    parseable_emails = VALID_EMAILS

    assert_parseable parseable_emails, method(:email?)
  end

  test 'returns an error for invalid emails' do
    not_parseable_emails = INVALID_EMAILS
    assert_not_parseable not_parseable_emails, method(:email?), EXPECTED_EMAIL_FORMAT
  end

end