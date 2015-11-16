class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    comment_params = params.require(:comment).permit(:body)
    @i = Idea.find params[:idea_id]
    @comment = Comment.new comment_params
    @comment.idea = @i
    @comment.user = current_user

    if @comment.save
      redirect_to idea_path(@i), notice: "Comment created succussfully!"
    else
      @comments = @i.comments.order(created_at: :desc)
      render "ideas/show"
    end
  end

  def destroy
    comment = Comment.find_by_id params[:id]
    if comment
      redirect_to idea_path(params[:idea_id]), alert: "Access denied." and return unless can? :destroy, comment
      comment.destroy
      redirect_to idea_path(comment.idea), notice: "Comment deleted"
    else
      redirect_to idea_path(params[:idea_id]), notice: "Comment already deleted"
    end

  end

end
