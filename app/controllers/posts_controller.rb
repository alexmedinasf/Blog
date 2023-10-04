class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @posts = @user.posts.includes(:comments)
  end

  def new
    post = Post.new
    respond_to do |f|
      f.html { render :new, locals: { post: } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.author = current_user
    respond_to do |f|
      f.html do
        if post.save
          flash[:success] = 'Post created successfully'
          redirect_to user_posts_path(current_user.id)
        else
          flash.now[:error] = 'Error: Post could not be created'
          render :new, status: :unprocessable_entity, locals: { post: }
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
