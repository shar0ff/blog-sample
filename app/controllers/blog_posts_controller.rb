class BlogPostsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy] # only: [...] is opposite to except: [...]
  def index
    @blog_posts = current_user&.admin? ? BlogPost.sorted: BlogPost.published.sorted
    @pagy, @blog_posts = pagy(@blog_posts)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
    # another option to replace line above:
    # params[:page] = 1
    # retry
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :cover_image, :content, :published_at)
  end

  def set_blog_post
    @blog_post = current_user&.admin? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end