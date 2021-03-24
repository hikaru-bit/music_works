class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @users = User.all
    @posts = @user.posts
  end

  def index
    @posts = Post.all
    @posts = Post.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    tag_list = params[:post][:tag_ids].split(',')
    post.save
    post.save_tags(tag_list)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:name).join(",")
    if @post.user_id != current_user.id
			redirect_to books_path
		end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
       @post.save_tags(tag_list)
       redirect_to post_path(@post)
    else
      render :edit
    end
  end

   private
  def post_params
    params.require(:post).permit(:title, :is_recruitment, :state, :is_online, :period, :guarantee, :text, :video)
  end

end
