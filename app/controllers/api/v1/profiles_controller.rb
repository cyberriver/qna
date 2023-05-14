class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    render json: current_resource_owner, serializer: UserSerializer
  end  

  def index
    @users = User.where('id != ?', current_resource_owner.id)
    render json: @users, each_serializer: UserSerializer
  end

end