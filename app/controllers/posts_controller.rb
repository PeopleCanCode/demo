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

  private
    def allowed_params
      params.require(:post).permit(:title, :body)
    end
end
