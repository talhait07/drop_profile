class HomeController < ApplicationController
  layout 'public', only: [:index]

  def index
    redirect_to user_root_path  if user_signed_in?

    @top_users = User.top_users
  end

  def load_states
    @country_code = params[:country_code]

    respond_to do |format|
      format.js
    end
  end

  def privacy_policy

  end

  def terms_of_use

  end

  def sitemap
    file_name = params[:file_name].present? ? params[:file_name] : 'sitemap'
    path = Rails.root.join('public', 'sitemaps', "#{file_name}.xml")
    if File.exists?(path)
      render xml: open(path).read
    else
      render text: 'Sitemap not found.', status: :not_found
    end
  end

  def robots
  end

  def send_resume_by_email
    if params[:email][:subject].present? && params[:email][:receiver].present? && params[:email][:body].present?
      from = current_user.present? ? current_user.email : params[:email][:sender]
      SendResume.email_resume(from, params[:email][:receiver], params[:email][:subject], params[:email][:body]).deliver
      redirect_to root_path, :notice => "Email Sent successfully!"
    else
      redirect_to root_path, :notice => "Mandatory fields cannot remain blank!"
    end
  end

  def subscribe
    gb = Gibbon::API.new(CONFIG[:mailchimp_api_key])
    gb.lists.subscribe({:id => CONFIG["#{site_name}_subscribers_list_id".to_sym], :email => {:email => params[:email]}, :double_optin => false})
    Rails.logger.info "------------------- #{gb.inspect} -------------------"
    flash.now[:success] = 'Your email address added successfully'
  rescue
    flash.now[:error] = 'Failed to add your email address'
  end
end
