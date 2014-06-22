class SlugsController < ApplicationController

  def slug
    User.all.each { |u| u.save; }
    Post.all.each { |p| p.save; }
    Category.all.each { |c| c.save; }

    redirect_to root_path
  end

end