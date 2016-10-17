# user_id:integer, template_id:integer, active:boolean(default: false), last_activated_at:dateTime(default: ), active_count:integer(default: 0), color:staring
class UserTemplate < ActiveRecord::Base
  # == Include Modules == #

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  belongs_to :user
  belongs_to :template

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
end
