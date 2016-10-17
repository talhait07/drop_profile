class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit_profile, :update_profile]

  def index
    # unless current_user.confirmed?
    #   # flash.now[:error] = "Your email not verified yet. Please verify your email within #{current_user.last_time_to_confirm_email.strftime('%d %b %Y %I:%M%p %Z')}"
    #   flash.now[:alert_not_close] = "Your email not verified yet. Please verify your email within address. <a href='#{new_confirmation_path(current_user)}'>Didn't receive confirmation instructions?</a>"
    # end

    @current_template = current_user.active_template
    @my_templates = current_user.inactive_templates
    @unique_visitors = @current_profile.impressions.distinct.group_by {|art| art.message}
    @current_profile.impressionist_count

    begin
      api_url = YAML.load_file('config/config_difference.yml')['blog']['recent_posts']
      blog_response = HTTParty.get api_url
      @blog_posts = blog_response.parsed_response
    rescue Exception => ex
      Rails.logger.error "Blog load error: #{ex.message}"
      @blog_posts = []
    end

    @add_modules = []
    (1..10).each do |module_number|
      @add_modules[module_number] = advertisements_by_category("Dashboard-#{module_number}")
    end
  end

  def edit_profile
  end

  def update_profile
    @user.update(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, profile_attributes: [:title, :state, :country, :phone])
  end

  def set_user
    @user = current_user
  end
end
