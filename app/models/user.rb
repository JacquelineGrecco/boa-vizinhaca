# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,
            presence: true,
            length: { maximum: 128 }

  validates :email,
            uniqueness: true,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            length: { maximum: 128 }

  belongs_to :neighbour, foreign_key: 'neighbours_id'
end
