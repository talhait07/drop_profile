# :user_id, :title, :username, :address, :city, :state, :country, :phone, :status, :web_link, :facebook_link, :twitter_link,
# :linkedin_link, :google_plus_link, :slug, gender:string, date_of_birth:date, completeness:integer
class Profile < ActiveRecord::Base
  # == Include Modules == #
  extend FriendlyId
  include ProfileCompleteness

  friendly_id :username, use: [:slugged, :finders]
  is_impressionable

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  belongs_to :user

  # == Validations == #

  # == Callbacks == #
  before_create :assign_username

  # == Scopes and Other macros == #
  scope :all_profiles, -> { where('username NOT IN (?)', %w(demo demo_user admin admin_user)) }

  # == Instance methods == #
  def location
    country = Carmen::Country.coded(self.country)
    if country.present? && self.state.present?
      location = country.subregions? ? country.subregions.coded(self.state).name : self.state
      location += ", "
    else
      location = ''
    end
    country.present? ? location + country.name : nil
  end

  def only_country
    country = Carmen::Country.coded(self.country)
    country.present? ? country.name : nil
  end

  def should_generate_new_friendly_id?
    slug.blank? || username_changed?
  end

  # == Private == #
  private
  def assign_username
    self.username = self.user.username
  end
end
