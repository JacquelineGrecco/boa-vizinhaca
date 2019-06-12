# frozen_string_literal: true

require_relative 'application_controller'

class OccurrencesController < ApplicationController

  before_action :index, :fetch_neighbour
  before_action :index, :set_location

  def index
    @occurrences = {
        robbery: fetch_occurrences(:robbery),
        theft: fetch_occurrences(:theft),
        assault: fetch_occurrences(:assault),
        rape: fetch_occurrences(:rape),
        traffic: fetch_occurrences(:traffic)
    }

    @occurrences_monthly_data = {
        robbery: fetch_occurrences_data(:robbery),
        theft: fetch_occurrences_data(:theft),
        assault: fetch_occurrences_data(:assault),
        rape: fetch_occurrences_data(:rape),
        traffic: fetch_occurrences_data(:traffic)
    }

    @criminality_indexes = Neighbour.order(criminality_index: :desc).limit(5)

    @neighbours = Neighbour.order(:name).all
  end

  private

  def fetch_occurrences(occurrence_kind)
    neighbours = Neighbour
                     .with_occurrence_count(occurrence_kind)
                     .occurrences_desc
                     .limit(5)
    translation = Occurrence.translate_kind(occurrence_kind)
    neighbours.map do |neighbour|
      {
          amount: neighbour.occurrences_count,
          type: occurrence_kind.to_s,
          type_string: translation[:type_string],
          type_string_plural: translation[:type_string_plural],
          location: {
              name: neighbour.name
          }
      }
    end
  end

  def fetch_occurrences_data(occurrence_kind, months_ago: 5)
    0.upto(months_ago).map do |i|
      date = Time.now - i.months
      query = Occurrence.by_year_and_month(year: date.year, month: date.month).where(kind: occurrence_kind)
      if @neighbour.present?
        query = query.joins(street: [:neighbour]).where(streets: {neighbour: @neighbour})
      end

      {
        date_label: "#{date.strftime("%Y/%m")}",
        occurrence_count: query.count
      }
    end.reverse
  end

  def fetch_neighbour
    @neighbour = Neighbour.find_by_id params[:neighbour_id]
  end

  def set_location
    @location = {name: @neighbour.try(:name) || 'São Paulo'}
  end
end
