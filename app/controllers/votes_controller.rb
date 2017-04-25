class VotesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    post.votes.create(user: current_user) unless Vote.find_by(user: current_user, post: post)
    redirect_back(fallback_location: root_path)
  end

end
