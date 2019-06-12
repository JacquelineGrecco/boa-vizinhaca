require_relative 'base_util_test'

class TimeUtilsTest < BaseUtilTest

  def parseable_times
    [
        Time.now,
        '2018-09-09',
        Time.now - 1.day
    ]
  end

  def unparseable_times
    [
        'not really a time',
        nil
    ]
  end

  test 'assert parse_time returns time instances for parseable times' do
    parseable_times.each do |time|
      parsed_time = TimeUtils.parse time
      assert parsed_time.is_a? Time
    end
  end

  test 'assert parse_time returns nil for unparseable times' do
    unparseable_times.each do |time|
      parsed_time = TimeUtils.parse time
      assert_nil parsed_time
    end
  end

  test 'assert month_interval returns correct interval for parseable times' do
    parseable_times.each do |time|
      parsed_time = TimeUtils.parse time
      expected_interval = parsed_time.utc.beginning_of_month..parsed_time.utc.end_of_month
      month_interval = TimeUtils.month_interval parsed_time

      assert_equal expected_interval, month_interval
    end
  end

  test 'assert year_interval returns correct interval for parseable times' do
    parseable_times.each do |time|
      parsed_time = TimeUtils.parse time
      expected_interval = parsed_time.utc.beginning_of_year..parsed_time.utc.end_of_year
      year_interval = TimeUtils.year_interval parsed_time

      assert_equal expected_interval, year_interval
    end
  end

  test 'assert month_day returns correct interval for parseable times' do
    parseable_times.each do |time|
      parsed_time = TimeUtils.parse time
      expected_interval = parsed_time.utc.beginning_of_day..parsed_time.utc.end_of_day
      day_interval = TimeUtils.day_interval parsed_time

      assert_equal expected_interval, day_interval
    end
  end

end