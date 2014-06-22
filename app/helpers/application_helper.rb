module ApplicationHelper

  def fix_url(url_string)
    url_string.starts_with?('http://') ? url_string : "http://#{url_string}"
  end

  def datetime_formatter(datetime)
    if datetime
      time_zone = (current_user) ? current_user.time_zone : "UTC"
      datetime.in_time_zone(time_zone).strftime("%d %b %Y,%l:%M %p (%Z%z)")
    else
      "at unknown time"
    end
  end

  def period(datetime)
    if datetime
      "#{distance_of_time_in_words_to_now(datetime)} ago"
    else
      "at unknown time"
    end
  end

  def display_user(user)
    (user.nil?) ? 'Anonymous' : user.username
  end

  def display_timezone_info(country_string)
    Time.find_zone(country_string).to_s
  end

  def vote_score_color(total_votes_score)
    if total_votes_score > 0
      return "vote-score-positive"
    elsif total_votes_score == 0
      return "vote-score-neutral"
    else
      return "vote-score-negative"
    end
  end

  def vote_score_id(obj)
    ending_name = obj.try(:slug) || obj.id
    "vote-score-#{obj.class.to_s.downcase}-#{ending_name}"
  end

end
