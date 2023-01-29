class FilesController < ApplicationController  
  before_action :authenticate_user!

  def purge
    file = ActiveStorage::Attachment.find(params[:id])
    file.purge
    redirect_back fallback_location: root_path, notice: "file deleted success"    
  end  
end
