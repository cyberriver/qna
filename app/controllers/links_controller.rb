class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_link

  def destroy
    @link.destroy if current_user.author_of?(@link.linkable)
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end