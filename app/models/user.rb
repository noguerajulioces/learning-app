# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :trackable, :confirmable

  def to_s
    email
  end

  has_many :courses

  rolify

  after_create :assign_default_role

  def assign_default_role
    add_role(:student) if roles.blank?

    if User.count == 1
      add_role(:admin) if self.roles.blank?
      add_role(:teacher)
      add_role(:student)
    else
      add_role(:student) if self.roles.blank?
      add_role(:teacher)
    end
  end

  validate :must_have_a_role, on: :update

  def online?
    updated_at > 1.minutes.ago
  end

  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "Must have at least one role")
    end
  end
end
