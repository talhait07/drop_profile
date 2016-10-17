# name:string, email:string, category:string, title:string body:text
class AdminContact < ActiveRecord::Base
  # == Include Modules == #

  # == Constants == #
  CATEGORIES = {
    query: 'Query',
    suggestion: 'Suggestion',
    report: 'Report',
    advertisement: 'Advertisement',
    other: 'Other'
  }

  # == Attributes == #

  # == File Uploader == #

  # == Associations and Nested Attributes == #

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
end
