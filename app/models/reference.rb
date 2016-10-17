# :name, :designation, :company, :location, :email, :phone
class Reference < ActiveRecord::Base
  # == Include Modules == #
  include ProfileCompleteness

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  belongs_to :user

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
end
