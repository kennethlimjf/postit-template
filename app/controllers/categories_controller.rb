class CategoriesController < ApplicationController
  before_action :authorize_user, only: [:new, :create]
  before_action :authorize_admin, only: [:new, :create]
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Category has been created.'
      redirect_to new_category_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end


  private
    def category_params
      params.require(:category).permit(:name)
    end
end