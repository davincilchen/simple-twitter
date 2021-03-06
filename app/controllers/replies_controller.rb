class RepliesController < ApplicationController
  before_action :set_tweet, only:[:index, :create]

  def index
    @reply = Reply.new
    @user = @tweet.user
    @replies = @tweet.replies.order(:created_at)
  end

  def create
    @reply = @tweet.replies.build(reply_params)
    @reply.user = current_user
    if !@reply.save
      flash[:alert] = @reply.errors.full_messages.to_sentence
    end
    redirect_to tweet_replies_path
  end

 private

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

end
