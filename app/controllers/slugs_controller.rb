class SlugsController < ApplicationController
  before_action :authorize_admin, only: :slug

  def slug
    User.all.each { |u| u.update_column(:slug, nil); }
    User.all.each { |u| u.generate_slug(:username); u.save(validate: false); }

    Post.all.each { |p| p.update_column(:slug, nil); }
    Post.all.each { |p| p.generate_slug(:title); p.save(validate: false); }

    Category.all.each { |c| c.update_column(:slug, nil); }
    Category.all.each { |c| c.generate_slug(:name); c.save(validate: false); }

    redirect_to root_path
  end

  def admin
    current_user.role = 'admin'
    current_user.save
    redirect_to root_path
  end

  def normal
    current_user.role = nil
    current_user.save
    redirect_to root_path
  end

end