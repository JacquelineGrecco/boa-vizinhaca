# frozen_string_literal: true

class Occurrence < ApplicationRecord
  TRANSLATIONS = {
    robbery: {
      type_string: 'roubo',
      type_string_plural: 'roubos'
    },
    theft: {
      type_string: 'furto',
      type_string_plural: 'furtos'
    },
    traffic: {
      type_string: 'apreensão de droga',
      type_string_plural: 'apreensões de droga'
    },
    rape: {
      type_string: 'estupro',
      type_string_plural: 'estupros'
    },
    assault: {
      type_string: 'agressão',
      type_string_plural: 'agressões'
    }
  }.freeze

  DEFAULT_TRANSLATION = { type_string: 'ocorrência', type_string_plural: 'ocorrências' }

  enum kind: %i[robbery theft traffic rape assault]
  belongs_to :street

  scope :robberies, -> { where(kind: :robbery) }
  scope :thefts, -> { where(kind: :theft) }
  scope :traffics, -> { where(kind: :traffic) }
  scope :rapes, -> { where(kind: :rape) }
  scope :assaults, -> { where(kind: :assault) }

  def self.translate_kind(kind)
    TRANSLATIONS[kind] || DEFAULT_TRANSLATION
  end

  def self.by_year_and_month(year:, month:)
    from = Date.new(year, month, 01)
    to = Date.new(year, month, 01).end_of_month
    where("reported_at >= '#{from}' AND reported_at <= '#{to}'")
  end

  def self.indexes
    {
      theft: 0.05,
      robbery: 0.1,
      traffic: 0.1,
      rape: 0.7,
      assault: 0.05
    }
  end
end
