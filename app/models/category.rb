# title:string

class Category < ActiveRecord::Base
  # == Include Modules == #

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #
  has_and_belongs_to_many :advertisements

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
end
