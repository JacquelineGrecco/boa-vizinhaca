# frozen_string_literal: true
require_relative 'bulk'

module Generators
  module_function
  def generate_occurrences(months_ago: 6, amount_per_day: 10)
    puts "Creating around #{months_ago * 30 * amount_per_day} random occurrences..."
    street_ids = Street.ids
    occurrence_params = []
    from = months_ago.months.ago.beginning_of_month.to_date
    to = Time.now.to_date

    from.upto(to).each do |date|
      1.upto(amount_per_day) do
        occurrence_params << {
          kind: Occurrence.kinds.values.sample,
          reported_at: date,
          street_id: street_ids.sample
        }
      end
    end

    DB.insert_many(Occurrence, occurrence_params)
  end
end
