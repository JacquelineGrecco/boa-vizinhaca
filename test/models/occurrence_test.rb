# frozen_string_literal: true

require 'test_helper'

class OccurrenceTest < ActiveSupport::TestCase

  def street
    streets(:piratininga)
  end

  test 'disallows occurrences without street' do
    assert_raise ActiveRecord::RecordInvalid do
      Occurrence.create! kind: :theft, reported_at: Time.now
    end
  end

  test 'disallows occurrences without kind' do
    assert_raise ActiveRecord::NotNullViolation do
      Occurrence.create! street: street, reported_at: Time.now
    end
  end

  test 'disallows occurrences with inconsistent kind' do
    assert_raise ArgumentError do
      Occurrence.create! kind: :INVALID, reported_at: Time.now, street: street
    end
  end

  test 'disallows occurrences without report time info' do
    assert_raise ActiveRecord::NotNullViolation do
      Occurrence.create! kind: :theft, street: street
    end
  end

  test 'ensures indexes values sum equals 1.0' do
    assert_equal 1.0, Occurrence.occurrences_indexes.values.sum
  end
end
