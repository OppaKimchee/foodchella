class PostsController < ApplicationController

  def index
    @posts = Post.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')
  end

  def show
    @post = Post.find(params[:id])
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

  def random
    post = Post.all.sample
    redirect_to post_path(post)
  end

  def profile
  end

  def all
    @posts = current_user.posts.all
  end

  private
    # Implement Strong Params
    def post_params
      params.require(:post).permit(:image,:description)
    end

end
