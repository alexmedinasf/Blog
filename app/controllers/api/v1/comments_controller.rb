class Api::V1::CommentsController < ApiController
    def index
      @post = Post.find(params[:post_id])
      @comments = @post.comments.order(created_at: :desc)
  
      render json: @comments
    end
  end