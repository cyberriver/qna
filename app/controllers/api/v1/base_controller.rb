class Api::V1::BaseController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  skip_before_action :gon_params_user
  before_action :doorkeeper_authorize!

  private

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def render_resource_errors(resource)
    render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
  end

  def current_ability
    @ability ||= Ability.new(current_resource_owner)
  end
end