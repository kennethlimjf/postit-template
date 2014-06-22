class CommentsController < ApplicationController
  before_action :authorize_user, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Comment has been created.'
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def vote
    vote = Comment.find(params[:id]).votes.create(creator: current_user, vote: params[:vote])

    if vote.valid?
      flash[:notice] = "Your vote has been submitted."
    else
      flash[:error] = "#{vote.errors[:creator].first}"
    end

    redirect_to :back
  end
end