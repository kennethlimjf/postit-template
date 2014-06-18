module ApplicationHelper

  def fix_url(url_string)
    url_string.starts_with?('http://') ? url_string : "http://#{url_string}"
  end

  def datetime_formatter(datetime)
    if datetime
      "#{distance_of_time_in_words_to_now(datetime)} ago at #{datetime.localtime.strftime("%d %b %Y,%l:%M %p (%Z%z)")}"
    else
      "at unknown time"
    end
  end

  def display_user(user)
    (user.nil?) ? 'Anonymous' : user.username
  end

end
