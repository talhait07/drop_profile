# title: string, company: string, location: string, designation: string, description: text, start_date: date, end_date: date, current: boolean
# "title" field now unused (removed from form)
class Experience < ActiveRecord::Base
  # == Include Modules == #
  include ProfileCompleteness

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  belongs_to :user

  # == Validations == #

  # == Callbacks == #
  after_create :activity_profile_to_facebook
  after_destroy :activity_profile_to_facebook

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
  def activity_profile_to_facebook
    self.user.facebook_activity(CONFIG[:host], 'dropresume:update')
  end
end
