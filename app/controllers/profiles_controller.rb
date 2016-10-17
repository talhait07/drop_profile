class ProfilesController < ApplicationController
  require 'geoip'
  before_action :authenticate_user!, except: :show
  before_action :set_profile, only: [:edit, :update, :destroy, :show]
  before_action :check_user_before_edit, only: [:edit]

  respond_to :html

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    @user = User.friendly.find params[:id]
    @template = @user.active_template
    @color = @user.template_color
    # pdf = Template1Pdf.new(@user, color)
    location = GeoIP.new('GeoIP.dat').country(request.ip)
    impressionist(@profile, location.present? ? location[:country_code2] : 'country_not_detected') rescue nil

    respond_to do |format|
      # format.pdf { send_data pdf.render, filename: "resume_template_#{ 1000 + template.id }", type: 'application/pdf', disposition: 'inline' }
      format.pdf do
        render :pdf => @user.full_name,
               :layout => false,
               :page_size => 'A4'
      end
      format.html { render layout: false }
    end
  end

  def new
    if current_user.profile.present?
      redirect_to edit_profile_url current_user.profile
      return
    end
    @profile = Profile.new
    respond_with(@profile)
  end

  def edit
    current_user.overview = Overview.new  if current_user.overview.blank?
    all = SampleObjective.all
    @sample_objective = all.limit(3).order("RANDOM()")
    tags = all.map{|objective| objective.tags}
    @objective_tags = tags.reject! { |tag| tag.empty? }
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.save
    respond_with(@profile)
  end

  def update
    current_user.update_attributes(user_params)
    if @profile.update(profile_params)
      flash.now[:success] = 'Your personal data update successfully.'
      @current_profile.reload
    else
      flash.now[:error] = 'Your personal data update failed.'
      add_error_messages(@profile)
    end
    respond_to do |f|
      f.js
      f.html { redirect_to action: :edit }
    end
  end

  def set_objective
    if params[:oid].present?
      @objective = SampleObjective.find_by(id: params[:oid])
      @sample_objective = SampleObjective.where("id != ?", @objective.id).limit(3).order("RANDOM()")
    else
      @load_more = true
      @sample_objective = SampleObjective.limit(3).order("RANDOM()")
    end
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  def update_profile_photo
    if params[:profile].present? && current_user.update_attributes(photo_params)
      flash[:success] = 'Successfully update you profile photo'
    else
      raise
      flash[:error] = 'Failed to update your profile photo'
    end
    respond_to do |format|
      format.html { redirect_to request.referrer || user_root_url }
    end
  end

  def update_username
    username = params[:profile]['username']
    if current_user.username == username || username_available?(username)
      if params[:profile].present?
        current_user.update_attributes(username_params)
      end
      current_user.reload
      @current_profile.reload

      respond_to do |format|
        format.json { render json: { username: current_user.username, public_url: profile_path(@current_profile) } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Username not available' } }
      end
    end
  end

  def tag
    #raise params.inspect
    if params[:tag].present?
      #@objective = SampleObjective.tagged_with(params[:tag])
      @sample_objective = SampleObjective.tagged_with(params[:tag])

    end
  end

  private
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params[:profile]['facebook_link'] = params[:profile]['facebook_link'].gsub(/https:\/\//, '').gsub(/http:\/\//, '')
    params[:profile]['twitter_link'] = params[:profile]['twitter_link'].gsub(/https:\/\//, '').gsub(/http:\/\//, '')
    params[:profile]['linkedin_link'] = params[:profile]['linkedin_link'].gsub(/https:\/\//, '').gsub(/http:\/\//, '')
    params[:profile]['google_plus_link'] = params[:profile]['google_plus_link'].gsub(/https:\/\//, '').gsub(/http:\/\//, '')
    params.require(:profile).permit(:user_id, :photo, :title, :date_of_birth, :gender, :address, :city, :state, :country, :phone, :status, :web_link, :facebook_link, :twitter_link, :linkedin_link, :google_plus_link, :slug)
  end

  def username_params
    params.require(:profile).permit(:username)
  end

  def photo_params
    params.require(:profile).permit(:photo)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def username_available?(username)
    User.where(username: username).empty?
  end

  def check_user_before_edit
    if current_user.profile != Profile.find(params[:id])
      redirect_to root_path, :flash => { :error => "you're trying to edit other user's profile!" }
    else
      return true
    end
  end
end
