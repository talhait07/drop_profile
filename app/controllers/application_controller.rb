class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :resource_params, if: :devise_controller?
  before_action :assign_global_variable
  before_action :set_cart

  helper_method :site_name, :current_cart

  def not_found
    # raise ActiveRecord::RecordNotFound
    raise ActionController::RoutingError.new 'Not found'
  end

  def advertisements_by_category(category)
    advertises = all_my_country_advertisements
    advertises = advertises.present? ? advertises.select{ |adv| adv.categories.present? && adv.categories.map(&:title).include?(category) } : []
    (advertises + Advertisement.where(all_category: true).try(:order, 'RANDOM()')).uniq
  end

  def all_my_country_advertisements
    current_country = Country.where(code: visitor_country_code).first
    advertises = current_country.try(:advertisements).try(:order, 'RANDOM()') || []
    (advertises + Advertisement.where(all_country: true).try(:order, 'RANDOM()')).uniq
  end

  def site_name
    if Rails.env.development?
      'dropresume'
    elsif Rails.env.production?
      host_array = request.host.split('.')
      host_array[host_array.length - 2].downcase
    elsif Rails.env.staging?
      host_array = request.host.split('.')
      host_array[host_array.length - 3].downcase
    else
      'dropresume'
    end
  end

  def current_cart
    session[:cart_id] ||= Cart.create!.id
    @current_cart = Cart.find(session[:cart_id])
  end

  def set_cart
    @total_count = current_cart.try(:line_items).try(:count)
  end

  protected

  def assign_global_variable
    @current_profile = user_signed_in? ? current_user.profile : nil
  end

  def add_error_messages(object)
    if object.present? && object.errors.present?
      flash[:error] += '<ul>'
      object.errors.full_messages.each do |message|
        flash[:error] += "<li>#{message}</li>"
      end
      flash[:error] += '</ul>'
    end
  end

  def admin_authorization
    redirect_to new_user_session_path unless current_user.present? && current_user.is_admin?
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for :sign_up do |u|
      u.permit(:username, :first_name, :last_name, :current_password, :email, :password, :password_confirmation, :photo, :default_site)
    end

    devise_parameter_sanitizer.for :account_update do |u|
      u.permit(:username, :first_name, :last_name, :current_password, :email, :password, :password_confirmation, :photo, :default_site)
    end

    devise_parameter_sanitizer.for :account_update do |u|
      u.permit(:password, :password_confirmation, :current_password)
    end
  end

  def resource_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :current_password, :password, :password_confirmation, :photo, :default_site)
  end

  def visitor_country_code
    ip = ['development', 'test'].include?(Rails.env) ? '103.242.217.18' : request.ip
    location = GeoIP.new('GeoIP.dat').country(ip)
    location.present? ? location[:country_code2] : nil
  end
end
