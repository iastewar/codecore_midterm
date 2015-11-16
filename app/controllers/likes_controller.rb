class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    like          = Like.new
    idea      = Idea.find params[:idea_id]
    like.idea = idea
    like.user     = current_user
    if like.save
      #LikesMailer.notify_idea_owner(like).deliver_later
      redirect_to idea_path(idea), notice: "Thanks for liking!"
    else
      redirect_to idea_path(idea), alert: "Can't like! Liked already?"
    end
  end

  def destroy
    idea = Idea.find params[:idea_id]
    like     = current_user.likes.find params[:id]
    like.destroy
    redirect_to idea_path(idea), notice: "Like removed!"
  end

end
