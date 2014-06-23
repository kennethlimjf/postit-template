module Sluggable
  extend ActiveSupport::Concern

  def generate_slug(property)
    generated_slug = self[property].strip.gsub(/[[:space:]]/, "-").gsub(/[^A-Za-z0-9\-]/, "").gsub(/-+/, "-").downcase

    size = nil
    counter = 0
    until size == 0
      if counter == 0
        size = self.class.where('slug LIKE ?', "#{generated_slug}").size
      else
        size = self.class.where('slug LIKE ?', "#{generated_slug}-#{counter}").size
      end
      counter+=1 if size > 0
    end

    generated_slug = "#{generated_slug}-#{counter}" if counter > 0
    self.slug = generated_slug
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def has_slug(slugname)
      slugname = slugname.to_sym
      before_create { self.generate_slug slugname }
    end
  end
end