# templates: { user_id:integer, code:integer, name:string, style:string, price:float, colors:string, image:string, uploaded_file:string, formatted_file:string, is_approved:bool, is_published:bool, status:string }
class Template < ActiveRecord::Base
  # == Include Modules == #
  extend FriendlyId

  friendly_id :name, use: [:slugged, :finders]

  # == Constants == #

  # == Attributes == #

  # == File Uploader == #
  mount_uploader :image, TemplateImageUploader
  # mount_uploader :uploaded_file, TemplateFileUploader
  # mount_uploader :formatted_file, TemplateFileUploader

  # == Associations and Nested Attributes == #
  belongs_to :user
  has_many :user_templates
  has_many :users, through: :user_templates
  has_many :line_items

  # == Validations == #

  # == Callbacks == #

  # == Scopes and Other macros == #
  scope :published, -> { where(is_published: true) }

  # == Instance methods == #
  def color_codes
    self.colors.split(',').map(&:strip)
  end

  def default_color
    self.colors.split(',').first.try(:strip)
  end

  def active_user_count
    self.user_templates.where(active: true).count
  end

  # == Private == #
end
