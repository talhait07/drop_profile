# :name, :level, :match
class Skill < ActiveRecord::Base
  # == Include Modules == #
  include ProfileCompleteness

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  belongs_to :user

  # == Validations == #

  # == Callbacks == #
  before_save :nil_check
  after_create :activity_profile_to_facebook
  after_destroy :activity_profile_to_facebook

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
  def nil_check
    self.level = self.level || 0
  end

  def activity_profile_to_facebook
    self.user.facebook_activity(CONFIG[:host], 'dropresume:update')
  end
end
