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
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@user.id, @post.id)
    else
      flash.now[:error] = 'Error: Comment could not be created'
      render :new, locals: { comment: @comment }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
