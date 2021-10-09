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
end
