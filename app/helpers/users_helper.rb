module UsersHelper
  # devise helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    User
  end

  def devise_error_messages
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="col-lg-12">
      <div class="alert alert-danger alert-dismissible" role="alert">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <ul style="list-style: none">#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end
end
