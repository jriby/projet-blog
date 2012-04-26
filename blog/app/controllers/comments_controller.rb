class CommentsController < ApplicationController
  include SessionsHelper

  before_filter :must_be_connected, :except => [:new, :create]

  def new
    @post = Post.find_by_id(params[:post_id])
  end
  def create
    @post = Post.find_by_id(params[:post_id])
    @post.comments.create(params[:comment])
    redirect_to(post_path(@post))
  end

  def destroy
    post = Post.find_by_id(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.destroy
    redirect_to(post_path(post))
  end


end
