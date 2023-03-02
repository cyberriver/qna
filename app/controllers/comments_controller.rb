class CommentsController < ApplicationController

  include ResourceCommented
  
  def index
    
  end

  def new
    @comment = @resource_commented.comments.new    
  end

  def create
    @comment =  @resource_commented.comments.new(comment_params)
    if @comment.save           
      redirect_to questions_path, notice: 'Your comment successfully created.'
    else
      render :new
    end   
  end

  def update
    
  end

  def destroy
    
  end

  private

  def comment_params
   params.require(:comment).permit(:value, :author_id)
    
  end
end