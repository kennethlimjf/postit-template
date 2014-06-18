module ApplicationHelper

  def fix_url(url_string)
    url_string.include?('http://') ? url_string : "http://#{url_string}"
  end

  def datetime_formatter(datetime)
    "#{distance_of_time_in_words_to_now(datetime)} ago at #{datetime.localtime.strftime("%d %b %Y,%l:%M %p (%Z%z)")}"
  end

end
