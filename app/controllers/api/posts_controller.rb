module Api
  class PostsController < ApplicationController
    def index
      @posts = Post.all

      respond_to do |format|
        format.json { render json: @posts }
        format.xml { render xml: @posts }
      end
    end
  end
end