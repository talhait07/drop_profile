# title:string, image:string, url:string, third_party_name:string, third_party_code:string, all_country:boolean, all_category:boolean

class Advertisement < ActiveRecord::Base
  # == Include Modules == #

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #
  mount_uploader :image, AdvertisementImageUploader

  # == Associations and Nested Attributes == #
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :countries

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #

  # == Instance methods == #

  # == Private == #
end
