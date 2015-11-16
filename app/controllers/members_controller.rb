class MembersController < ApplicationController
  before_action :authenticate_user

  # POST /ideas/12/members
  def create
    redirect_to idea_path(@i), alert: "Access denied." and return if can? :edit, @i
    member          = Member.new
    idea      = Idea.find params[:idea_id]
    member.idea = idea
    member.user     = current_user
    if member.save
      #MembersMailer.notify_idea_owner(member).deliver_later
      redirect_to idea_path(idea), notice: "Thanks for joining!"
    else
      redirect_to idea_path(idea), alert: "Can't join! Joined already?"
    end
  end

  def destroy
    redirect_to idea_path(@i), alert: "Access denied." and return if can? :edit, @i
    idea = Idea.find params[:idea_id]
    member     = current_user.members.find params[:id]
    member.destroy
    redirect_to idea_path(idea), notice: "Unjoined!"
  end

end
