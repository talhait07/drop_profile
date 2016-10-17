module ApplicationHelper
  def date_format(date, format='%d %b, %Y')
    date.try(:strftime, format)
  end

  def admin_signed_in?
    user_signed_in? && current_user.is_admin?
  end

  def flash_message
    html = '<div class="col-lg-12 flash-message-div">'

    flash.each do |key, message|
      if %w'error alert'.include?(key)
        html += <<-HTML
          <div class="alert alert-danger alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      elsif %w'alert_not_close'.include?(key)
        html += <<-HTML
          <div class="alert-not-close alert-danger alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      else
        html += <<-HTML
          <div class="alert alert-success alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      end
    end

    (html + '</div>').html_safe
  end

  def full_url(url)
    request.protocol + request.host_with_port + url
  end

  def blog_posts
    begin
      api_url = YAML.load_file('config/config_difference.yml')['blog']['recent_posts']
      blog_response = HTTParty.get api_url
      @blog_posts = blog_response.parsed_response.sort{|a,b| b['created_date'] <=> a['created_date']}
    rescue Exception => ex
      Rails.logger.error "Blog load error: #{ex.message}"
      @blog_posts = []
    end
  end

  def find_user(user)
    User.find(user)
  end

end