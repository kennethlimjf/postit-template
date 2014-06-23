module Sluggable
  extend ActiveSupport::Concern

  def generate_slug(obj, property)
    generated_slug = obj[property].strip.gsub(/[[:space:]]/, "-").gsub(/[^A-Za-z0-9\-]/, "").gsub(/-+/, "-").downcase

    size = nil
    counter = 0
    until size == 0
      if counter == 0
        size = obj.class.where('slug LIKE ?', "#{generated_slug}").size
      else
        size = obj.class.where('slug LIKE ?', "#{generated_slug}-#{counter}").size
      end
      counter+=1 if size > 0
    end

    generated_slug = "#{generated_slug}-#{counter}" if counter > 0
    self.slug = generated_slug
  end

  def to_param
    self.slug
  end

end