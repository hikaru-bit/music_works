class UsersController < ApplicationController

   def show
    @user = User.find(params[:id])
    @users = User.all
    @posts = @user.posts
   end

   def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(@current_user.id)
		end
   end

      def update
      		@user = User.find(params[:id])
      		if @user.update(user_params)
      			redirect_to user_path(@user.id)
      		else
      			render :edit
      		end
      end

      def review
        @user = User.find(params[:id])
      	@user.update!(review_params)
      	redirect_to user_path(@user.id)
      end

      def confirm
        @user = current_user.id
      end

      def withdraw
       @user = User.find(current_user.id)
        #現在ログインしているユーザーを@userに格納
        @user.update(is_deleted: "Available")
        #updateで登録情報をInvalidに変更
        reset_session
        redirect_to root_path
      end

    private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def review_params
    params.require(:user).permit(:evaluation)
  end


end
