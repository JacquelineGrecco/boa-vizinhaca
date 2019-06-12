module TimeUtils
  module_function

  def day_interval(time)
    time = parse time
    if time.present?
      time.utc.beginning_of_day..time.utc.end_of_day
    else
      nil
    end
  end

  def month_interval(time)
    time = parse time
    if time.present?
      time.utc.beginning_of_month..time.utc.end_of_month
    else
      nil
    end
  end

  def year_interval(time)
    time = parse time
    if time.present?
      time.utc.beginning_of_year..time.utc.end_of_year
    else
      nil
    end
  end

  # TODO: Test me
  def add_week_days(base_time, days_to_add)
    time = parse base_time
    if time.present?
      while days_to_add > 0
        time += 1.day
        days_to_add -= 1 unless time.saturday? || time.sunday?
      end

      time
    else
      nil
    end
  end


  def parse(time)
    return time if time.is_a? ::Time
    begin
      ::Time.parse time
    rescue StandardError
      nil
    end
  end

end