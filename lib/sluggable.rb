module Sluggable

  def generate_slug(obj, property)
    generated_slug = obj[property].strip.gsub(/[[:space:]]/, "-").gsub(/[^A-Za-z0-9\-]/, "").gsub(/-+/, "-").downcase

    count = nil
    until count == 0
      count = obj.class.where('slug LIKE ?', "#{generated_slug}%").count
      generated_slug = (count == 0) ? generated_slug : generated_slug+"-#{count+1}"      
    end

    self.slug = generated_slug
  end

  def to_param
    self.slug
  end

end