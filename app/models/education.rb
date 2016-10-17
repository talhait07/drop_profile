# user_id:integer, title:string, institute:string, location:string, major:string, result:string, description:text,
# start_date:date, end_date:date, created_at:datetime, updated_at:datetime, current:boolean

class Education < ActiveRecord::Base
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
