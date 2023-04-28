class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_link

  authorize_resource

  def destroy
    @link.destroy
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end