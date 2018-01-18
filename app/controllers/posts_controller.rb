class PostsController < ApplicationController
before_action :authenticate_user!, except: [:show, :index]
before_action :find_post, only: [:show, :edit, :update, :destroy]
before_action :authorize_user!, only: [:edit, :update, :destroy]

def new
  @post = Post.new
end

  def index
    @liked = params[:liked]
    if @liked
      @posts = current_user.liked_posts
    else
      @posts = Post.all.order(created_at: :desc)
      @liked_posts = @posts.sort_by { |post| post.likes.count }.reverse.first(7)
    end

  end

  def create
    @post = Post.new post_params

    @post.user = current_user

    if @post.save
      PostReminderJob.set(wait: 1.minute).perform_later(@post.id)
      # redirect_to @post
      redirect_to posts_path

    else
        render :new
      end
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
    @user_like = current_user.likes.find_by_post_id(@post) if user_signed_in?
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post edited successfully!'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy

    if @post.destroy
      flash[:success] = 'Post was deleted successfully!'
      redirect_to home_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @post)
      flash[:danger] = "Access denied!"
      redirect_to home_path
    end
  end


end
