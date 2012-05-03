class CommentsController < ApplicationController

  before_filter :must_be_connected, :except => [:new, :create]

  def new
    @post = Post.find_by_id(params[:post_id])
		respond_to do |format|
			format.js
			format.html
		end
  end
  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    #redirect_to(post_path(@post))
    respond_to do |format|

        format.html { redirect_to post_path(@post) }
        format.json { redirect_to post_path(@post) }
        format.js # new.js.erb

    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    

    respond_to do |format|
      format.html { redirect_to(post_path(@post)) }
      format.json { head :no_content }
      format.js # destroy.js.erb
    end
  end


end
