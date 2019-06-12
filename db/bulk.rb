# frozen_string_literal: true

module DB
  module_function

  def insert_many(active_record_class, data, amount: 50_000, add_timestamps: true)
    return [] if data.blank?

    if add_timestamps
      data = data.map do |attribute_hash|
        attribute_hash.merge(created_at: ::Time.now, updated_at: ::Time.now)
      end
    end
    if data.first.key?(:id) || data.first.key?('id')
      worker = active_record_class.bulk_insert(*data.first.keys, set_size: amount, return_primary_keys: true)
    else
      worker = active_record_class.bulk_insert(set_size: amount, return_primary_keys: true)
    end
    worker.add_all data
    worker.save!
    worker.result_sets.map(&:rows).flatten
  end
end
