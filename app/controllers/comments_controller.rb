class CommentsController < ApplicationController
  before_action :authorize_user, only: [:create, :vote]

  def create
    @post = Post.find_by( slug: params[:post_id] )
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
    @vote = Comment.find(params[:id]).votes.create(creator: current_user, vote: params[:vote])

    respond_to do |format|

      format.html do
        if @vote.persisted?
          flash[:notice] = "Your vote has been submitted."
        else
          flash[:error] = "#{vote.errors[:creator].first}"
        end

        redirect_to :back
      end

      format.js { render 'votes/vote' }

    end
  end

end