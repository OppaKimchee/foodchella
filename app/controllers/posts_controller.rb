class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    if params[:random]
      redirect_to cat_path(Post.all.sample)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_path
    else
      flash[:notice] = "Error Post not created!"
    end
  end

  private
    # Implement Strong Params
    def post_params
      params.require(:post).permit(:image,:description)
    end

end
