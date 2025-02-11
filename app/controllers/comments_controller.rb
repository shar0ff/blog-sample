class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @blog_post, notice: 'Comment created!'
    else
      redirect_to @blog_post, alert: 'Comment could not be created!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
