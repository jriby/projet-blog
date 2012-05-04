class PostsController < ApplicationController

  before_filter :must_be_connected, :except => [:index, :show]
  before_filter :post_exist, :except => [:index, :new ,:create]


  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @post = Post.create(params[:post])
    
    respond_to do |format|
      format.html { redirect_to(posts_path) }
      format.json { redirect_to(posts_path) }
      format.js # new.js.erb
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_path) }
      format.json { head :no_content }
      format.js # destroy.js.erb
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    @post.update_attributes(params[:post])

    respond_to do |format|
      format.html { redirect_to(posts_path) }
      format.json { redirect_to(posts_path) }
      format.js # new.js.erb
    end
  end
  def show
    @post = Post.find_by_id(params[:id])
  end
end
