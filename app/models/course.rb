# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  belongs_to :user
  def to_s
    title
  end

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  LEVELS = [
    'Beginner', 'Intermediate', 'Advanced'
  ].freeze

  LANGUAGE = [
    'Spanish', 'English', 'Russian', 'Portuguese'
  ].freeze

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }
end
