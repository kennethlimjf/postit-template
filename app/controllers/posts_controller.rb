class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:create, :edit, :new, :update, :vote]
  before_action :allow_edit_update, only: [:edit, :update]


  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post has been updated."
      redirect_to post_path(params[:id])
    else
      render :edit
    end
  end

  def explore; end

  def vote
    @vote = Post.find(params[:id]).votes.create(creator: current_user, vote: params[:vote])

    respond_to do |format|

      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote has been submitted."
        else
          flash[:error] = "#{vote.errors[:creator].first}"
        end
        redirect_to :back
      end

      format.js { render 'votes/vote' }

    end

  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def allow_edit_update
      unless @post.creator == current_user
        flash[:error] = "You do not own this post"
        redirect_to root_path
      end
    end
end
