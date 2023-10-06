class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
  end
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    comment = Comment.new(params.require(:comment).permit(:text))
    comment.author = current_user
    comment.post = @post
    if comment.save
      comment.update_comments_counter(params[:post_id])
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@user.id, @post.id)
    else
      flash.now[:error] = 'Error: Comment could not be created'
      render :_comment, status: :unprocessable_entity, locals: { comment: @comment }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    respond_to do |f|
      f.html do
        if comment.destroy
        comment.update_comments_counter(params[:post_id])
        flash[:success] = 'Comment deleted successfully'
        redirect_to user_post_path(params[:user_id], params[:post_id])
        else
        flash.now[:error] = 'Error: Comment could not be deleted'
        render :show, status: :unprocessable_entity, locals: { comment: }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end