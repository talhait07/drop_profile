class Users::PasswordsController < Devise::PasswordsController
  layout 'login', only: [:new, :create, :edit, :update]

  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    self.resource = User.find_by_email(resource_params['email'])
    host = Rails.env.development? ? 'hubcv.com' : request.host_with_port
    self.resource.send_reset_password_instructions(host)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end
end
