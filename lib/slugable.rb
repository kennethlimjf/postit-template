module Slugable

  def generate_slug(str)    
    self.slug = str.strip.gsub(/[[:space:]]/, "-").gsub(/[^A-Za-z0-9\-]/, "").gsub(/-+/, "-").downcase
  end

  def to_param
    self.slug
  end

end