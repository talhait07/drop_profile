# email:string, username:string, encrypted_password:string", first_name:string, last_name:string, reset_password_token:string,
# reset_password_sent_at:datetime, remember_created_at:datetime, sign_in_count:integer (default: 0), current_sign_in_at:datetime,
# last_sign_in_at:datetime, current_sign_in_ip:inet, last_sign_in_ip:inet, confirmation_token:string, confirmed_at:datetime,
# confirmation_sent_at:datetime, failed_attempts:integer(default: 0), unlock_token:string, locked_at:datetime, created_at:datetime,
# updated_at:datetime, auth_provider:string, auth_uid:string, photo:string, slug:string, auth_token:string

class User < ActiveRecord::Base
  # == Include Modules == #
  extend FriendlyId

  # devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, :validatable
  #:lockable, :omniauthable
  friendly_id :username, use: [:slugged, :finders]

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #
  mount_uploader :photo, UserPhotoUploader

  # == Associations and Nested Attributes == #
  has_one :profile, dependent: :destroy
  has_one :overview, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :hobbies_interests, dependent: :destroy
  has_many :user_templates, dependent: :destroy
  has_many :templates, through: :user_templates
  has_one :carts, dependent: :destroy

  accepts_nested_attributes_for :profile

  # == Validations == #
  validates :first_name, presence: true
  validates :username, presence: true, on: :create
  validates :username, uniqueness: true
  validates :email, presence: true, on: :create
  ## N.B: Devise already check uniqueness, don't check double
  validates :password, confirmation: true
  validates :password, presence: true, length: { minimum: 6, maximum: 25 }, on: :create
  validates_uniqueness_of :auth_uid, :scope => :auth_provider, if: :auth_validate_needs?

  # == Callbacks == #
  after_create :create_profile, :assign_default_templates, :facebook_activity_on_create
  after_update :update_profile
  after_save :update_profile_completeness
  # after_create :auto_subscribe_to_mailchimp

  # == Scopes and Other macros == #
  scope :all_without_demo_admin, -> { where('email not in (?)', %w'admin@dropresume.com demo@dropresume.com rezabyte@gmail.com arbabsarkar@gmail.com salayhin@gmail.com tauhidul35@gmail.com soniyahq@gmail.com') }
  scope :only_recommended_user, -> { where(:recommend => true) }

  # == Class Methods == #
  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    auth_user = find_by(auth_uid: auth.uid, auth_provider: auth.provider)

    user = signed_in_resource ? signed_in_resource : auth_user

    # Create the user if needed
    if user.nil?
      email = auth.info.email
      user = User.where(:email => email).first if email
      auth_token = auth.try(:credentials).try(:token)

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            first_name: auth.extra.raw_info.name,
            username: "#{auth.provider}_#{auth.uid}",
            email: email ? email : "change-me-#{auth.uid}@#{auth.provider}.com",
            password: Devise.friendly_token[0, 20],
            auth_uid: auth.uid,
            auth_provider: auth.provider,
            auth_token: auth_token
        )
        # user.skip_confirmation!
        user.save!
      end
    end
    user
  end

  def self.demo
    self.find_by_email 'demo@dropresume.com' rescue nil
  end

  def self.top_users(limit = 12)
    # self.all_without_demo_admin.joins(:profile).where('users.photo is not null and profiles.completeness >= 50').sort_by{|u| -u.count_profile_viewer}.first(limit)
    self.all_without_demo_admin.only_recommended_user.joins(:profile).where('users.photo is not null and profiles.completeness >= 50').shuffle.first(limit)
  end

  # def self.facebook_activity_delay(fb_user, con_name, url)
  #   fb_user.put_connections('me', con_name, resume: url)
  # end

  # == Instance methods == #
  def facebook_activity(share_url=CONFIG[:host], connection_name='dropresume:update')
    if self.auth_provider == 'facebook'
      share_to_facebook(self, connection_name, "http://#{share_url}")
    end
  end

  def full_name
    "#{self.first_name || ''} #{self.last_name || ''}"
  end

  def count_profile_viewer
    self.profile.impressionist_count
  end

  def template_color
    color = self.user_templates.where('user_templates.active' => true).first.try(:color)
    color || self.active_template.default_color
  end

  def active_template
    self.templates.where('user_templates.active' => true).first
  end

  def inactive_templates
    self.templates.where('user_templates.active' => false)
  end

  def is_admin?
    self.email == 'admin@dropresume.com'
  end

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  def current_experience_education
    self.experiences.where(current: true).order('start_date desc').first.try(:company)
    # current || self.educations.where(current: true).order('start_date desc').first.try(:institute)
  end

  def previous_experience_education
    self.experiences.where(current: false).order('end_date desc').first.try(:company)
    # current || self.educations.where(current: false).order('end_date desc').first.try(:institute)
  end

  def last_education
    self.educations.order('end_date desc').first.try(:institute)
  end

  # return user's profile completeness in percentage
  def profile_completeness
    self.profile.completeness
  end

  def profile_photo_link(version = nil)
    #ToDo Now skip the asset error by checking development env as staging/production env not show any asset runtime error and works fine
    # As there is no time to code optimisation I skip to solve this asset issue, you must solve it when you have enough time to code optimisation :)
    if Rails.env.development?
      (version.present? ? self.photo.url(version) : self.photo.url) || 'default_user_photo_male.png'
    else
      (version.present? ? self.photo.url(version) : self.photo.url) || ActionController::Base.helpers.image_url('default_user_photo_male.png')
    end
  end

  # Override devise reset password email send
  def send_reset_password_instructions(site)
    token = set_reset_password_token
    DeviseMailer.reset_password_instructions(self, token, site).deliver
    token
  end

  def send_confirmation_instructions
    unless @raw_confirmation_token
      generate_confirmation_token!
    end

    # opts = pending_reconfirmation? ? { to: unconfirmed_email } : { }
    DeviseMailer.confirmation_instructions(self, @raw_confirmation_token).deliver
    self
  end

  def auto_subscribe_to_mailchimp
    if Rails.env.production?
      api_key = 'a184f9a493e09235d45abbf96192291b-us7'
      list_id = 'bc3f789b40'
      gb = Gibbon::API.new(api_key)
      gb.lists.subscribe({:id => list_id, :email => {:email => self.email}, :merge_vars => {:FNAME => self.first_name, :LNAME => self.last_name}, :double_optin => false})
    end
  end

  def last_time_to_confirm_email
    self.confirmation_sent_at + User.allow_unconfirmed_access_for
  end

  # == Private Methods == #
  private
  def auth_validate_needs?
    self.auth_provider.present?
  end

  def create_profile
    Profile.create(user_id: self.id, username: self.username)
  end

  def assign_default_templates
    demo_user = User.demo
    if demo_user.present?
      demo_user.user_templates.each do |user_template|
        UserTemplate.create(user_id: self.id, template_id: user_template.template_id, active: user_template.active, last_activated_at: self.created_at, active_count: user_template.active? ? 1 : 0)
      end
    end
  end

  def update_profile
    if username_changed?
      self.profile.update_attributes(username: self.username, slug: self.username)
    end
  end

  def share_to_facebook(user, connection_name, share_url)
    return false unless user.present?
    facebook_user = Koala::Facebook::API.new(user.auth_token) rescue nil
    return false unless facebook_user.present?
    # User.delay.facebook_activity_delay(facebook_user, connection_name, share_url)
    facebook_user.put_connections('me', connection_name, resume: share_url)
  rescue
    Rails.logger.error 'Error occur to send profile activity to facebook'
  end

  def facebook_activity_on_create
    self.facebook_activity(CONFIG[:host], 'dropresume:update')
  end

  def update_profile_completeness
    if photo_changed?
      self.profile.save(validate: false)
    end
  end
end
