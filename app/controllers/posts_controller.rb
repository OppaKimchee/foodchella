class PostsController < ApplicationController

  def index
    @posts = Post.left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')
  end

  def show
    @post = Post.find(params[:id])
    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
    end
  end

  def new
    @post = Post.new
    @posts = Post.all
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
    end
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

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to all_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Implement Strong Params
    def post_params
      params.require(:post).permit(:image,:description,:latitude, :longitude)
    end

end
