class ImagesController < ApplicationController
  before_action :find_idea, only: [:edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def edit

  end

  def update
    redirect_to idea_path(@i), alert: "Access denied." and return unless can? :update, @i
    if @i.update idea_params
      redirect_to(idea_path(@i))
    else
      render :edit
    end
  end

  def destroy
    redirect_to idea_path(@i), alert: "Access denied." and return unless can? :update, @i
    @i.avatar = nil
    @i.save
    flash[:notice] = "Image deleted successfully"
    redirect_to idea_path(@i)
  end

  def idea_params
    params.require(:idea).permit([:image, :avatar])
  end

  def find_idea
    @i = Idea.find(params[:idea_id])
  end

end
