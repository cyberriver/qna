class CommentsController < ApplicationController
  after_action :publish_comment, only: [:create]

  include ResourceCommented
  authorize_resource
  
  def index
    
  end

  def show
    @comment = @resource_commented.comments.new
  end

  def new
    @comment = @resource_commented.comments.new
   
  end

  def create
    @comment =  @resource_commented.comments.new(comment_params)
    if @comment.save           
      redirect_to question_path(choose_render_param ), notice: 'Your comment successfully created.'
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
   params.require(:comment).permit(:title, :commentable_type, :commentable_id, :author_id)    
  end

  def publish_comment

    if @comment.errors.any?
      puts "LOG ERRORS: @comment.errors.any? #{@comment.errors.any?}"      

    else 
      ActionCable.server.broadcast(
      "comments_for_question_#{ choose_render_param }", {
        commentable_type: @resource_commented.class.name.downcase,
        commentable_id: @resource_commented.id,
        comment: render_comment,
        comments_count: @resource_commented.comments.count}     
      )
      
    end   
  
  end

  def render_comment

    AnswersController.render(
      partial: 'comments/comment',
      locals: { 
        comment: @comment }
    )    
  end

end