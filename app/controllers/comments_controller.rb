class CommentsController < ApplicationController
  after_action :publish_comment, only: [:create]

  include ResourceCommented
  
  def index
    
  end

  def show
    @comment = @resource_commented.comments.new
    puts "LOG action show: Comment #{@comment }"
  end

  def new
    @comment = @resource_commented.comments.new
   
  end

  def create
    @comment =  @resource_commented.comments.new(comment_params)
    puts "LOG action create: Comment #{@comment }"
    if @comment.save           
      redirect_to eval(choose_route), notice: 'Your comment successfully created.'
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

    puts "LOG STARTING PUBLISH ActionCable.server.broadcast to chanell comments_#{ choose_render_param }"
    puts "LOG @resource_commented #{choose_render_param }"
 
    if @comment.errors.any?
      puts "LOG ERRORS: @comment.errors.any? #{@comment.errors.any?}"      

    else 
      puts "choose_render_params #{choose_render_param }"
      puts "LOG publish comment @resource_commented #{@resource_commented}"
      ActionCable.server.broadcast(
      "comments_for_question_#{ choose_render_param }",
        commentable_type: @resource_commented.class.name.downcase,
        commentable_id: @resource_commented.id,
        comment: render_comment,
        comments_count: @resource_commented.comments.count     
      )
      puts "published"
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