class UsersController < ApplicationController
  before_action :set_user, only:[:tweets, :edit, :update, :followings ,:followers, :likes]

  def tweets
    @tweets = @user.tweets.order(created_at: :DESC)
  end

  def edit
    if @user != current_user
      redirect_to tweets_user_path(@user)
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "User was successfully update"
        redirect_to edit_user_path
      else
        flash.now[:alert] = "User was failed to update"
        render :edit
      end
    else
      redirect_to tweets_user_path(@user)
    end
  end

  def followings
    @followings =  Array.new # 基於測試規格，必須講定變數名稱
    @followships = @user.followships.order(created_at: :DESC)
    @followships.each do |followship|
      @followings.push(followship.following)
    end

  end

  def followers
    @followers = Array.new # 基於測試規格，必須講定變數名稱
    @followships = @user.inverse_followships.order(created_at: :DESC)
    @followships.each do |followship|
      @followers.push(followship.user)
    end
  end

  def likes
    @likes = Array.new # 基於測試規格，必須講定變數名稱
    @likeships = @user.likes.order(created_at: :DESC)
    @likeships.each do |like|
      @likes.push(like.tweet)
    end
  end

  private

  def user_params
     params.require(:user).permit(:name, :introduction ,:avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
