class Api::V1::CommentsController < ApiController
  before_action :authorize_request

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order(created_at: :desc)
    render json: @comments
  end

  def create
    @comment = Comment.new(text: params[:comment][:text])
    @comment.author = @current_user
    @comment.post_id = params[:post_id]
    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages },
              status: :unprocessable_entity
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end