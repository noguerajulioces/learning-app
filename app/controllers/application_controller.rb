# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include PublicActivity::StoreController

  after_action :user_activity

  private

  def user_activity
    current_user.try(:touch)
  end
end
