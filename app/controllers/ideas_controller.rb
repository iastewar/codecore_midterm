class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @i = Idea.new


  end

  def create
    @i = Idea.new(idea_params)
    @i.user = current_user
    if @i.save
      redirect_to(idea_path(@i), notice: "Idea created!")
    else
      render :new
    end
  end

  def show
    @comments = @i.comments.order(created_at: :desc)
    @comment = Comment.new
    @members = @i.member_users
  end

  def edit
    redirect_to idea_path(@i), alert: "Access denied." and return unless can? :edit, @i


  end

  def update
    redirect_to idea_path(@i), alert: "Access denied." and return unless can? :update, @i
    if @i.update idea_params
      redirect_to(idea_path(@i))
    else
      render :edit
    end
  end

  def index
    @ideas = Idea.order(updated_at: :desc)
  end

  def destroy
    redirect_to idea_path(@i), alert: "Access denied." and return unless can? :destroy, @i
    @i.destroy
    flash[:notice] = "Idea deleted successfully"
    redirect_to ideas_path
  end

  private

  def idea_params
    params.require(:idea).permit([:title, :body])
  end

  def find_idea
    @i = Idea.find(params[:id])
  end
end
