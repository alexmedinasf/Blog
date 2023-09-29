class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end
  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
  end

  def new
    post = Post.new
    respond_to do |f|
      f.html { render :new, locals: { post: post } }      
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.author = current_user
    respond_to do |f|
      f.html do
        if post.save
          flash[:success] = "Post created successfully"
          redirect_to user_posts_path(current_user.id)
        else
          flash.now[:error] = "Error: Post could not be created"
          render :new, locals: { post: post }
        end
      end
    end
  end
end