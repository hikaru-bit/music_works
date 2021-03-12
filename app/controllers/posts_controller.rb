class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.save
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
  end

   private
  def post_params
    params.require(:post).permit(:title, :is_recruitment, :state, :is_online, :period, :guarantee, :text)
  end

end
