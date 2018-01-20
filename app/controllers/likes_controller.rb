class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    if can? :like, post
      like = Like.new(post: post, user: current_user)
      if like.save
        redirect_to post, notice: "liked"
      else
        redirect_to post, alert: "didn't like"
      end
    else
      head :unauthorized
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like
      like.destroy
      redirect_to post_path(like.post), notice: 'like removed'
    else
      head :unauthorized
    end
  end

end
