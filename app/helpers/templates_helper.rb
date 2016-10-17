module TemplatesHelper
  def my_template?(template)
    user_signed_in? && template.user_ids.include?(current_user.id)
  end
end
