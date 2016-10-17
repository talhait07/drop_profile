# :name, :listening_level, :writing_level, :speaking_level
class Language < ActiveRecord::Base
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

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
  def nil_check
    self.listening_level = self.listening_level || 0
    self.writing_level = self.writing_level || 0
    self.speaking_level = self.speaking_level || 0
  end
end
