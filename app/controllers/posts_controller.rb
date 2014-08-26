class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.build(allowed_params)

    if @post.save
      flash[:success] = "Created new post"
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.user == current_user
      if @post.update_attributes(allowed_params)
        flash[:success] = "Updated post."
        redirect_to @post
      else
        render 'edit'
      end
    else
      redirect_to posts_path
      flash[:notice] = "You can't do this."
    end
  end

  private
    def allowed_params
      params.require(:post).permit(:title, :body)
    end
end
