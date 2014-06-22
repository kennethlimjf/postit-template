class SlugsController < ApplicationController

  def slug
    User.all.each { |u| u.valid?; u.save; }
    Post.all.each { |p| p.valid?; p.save; }
    Category.all.each { |c| c.valid?; c.save; }

    redirect_to root_path
  end

end