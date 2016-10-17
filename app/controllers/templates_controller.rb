class TemplatesController < ApplicationController
  before_action :admin_authorization, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:add_to_my, :remove_from_my, :activate]
  before_action :set_template, only: [:show, :details, :edit, :update, :destroy, :add_to_my, :remove_from_my]

  respond_to :html

  def index
    @templates = (user_signed_in? && current_user.is_admin?) ? Template.all : Template.published
    @templates = @templates.order('updated_at desc')
    respond_with(@templates)
  end

  def show
    @user = User.demo
    @color = params[:color] || @template.default_color
    # pdf = Template1Pdf.new(@user, @color)

    respond_to do |format|
      # format.pdf { send_data pdf.render, filename: "resume_template_#{ 1000 + @template.id }", type: 'application/pdf', disposition: 'inline' }
      format.pdf do
        render pdf: @template.name,
               layout: false,
               page_size: 'A4',
               margin:  { top: 10, bottom: 0, left: 0, right: 0 },
               # user_style_sheet: "#{CONFIG[:cdn_server_url]}/shared_files/css/bootstrap.min.css",
               show_as_html: false
      end
      format.html { render layout: false }
    end
  end

  def details
    respond_with(@template)
  end

  def new
    @template = Template.new
    respond_with(@template)
  end

  def edit
  end

  def create
    @template = Template.new(template_params)
    @template.user = current_user
    if @template.save
      redirect_to action: :index
    else
      respond_with(@template)
    end
  end

  def update
    @template.update(template_params)
    respond_with(@template)
  end

  def destroy
    @template.destroy
    respond_with(@template)
  end

  def add_to_my
    color = params[:color] || @template.default_color
    UserTemplate.find_or_create_by(user_id: current_user.id, template_id: @template.id, color: color)
    flash[:success] = 'Added template with your templates'
    respond_to do |format|
      format.html { redirect_to user_root_url }
    end
  end

  def remove_from_my
    destroyed = UserTemplate.destroy_all(user_id: current_user.id, template_id: @template.id)
    if destroyed.present?
      flash[:success] = 'Remove template from your templates'
    else
      flash[:error] = 'Unable co remove from your templates'
    end
    respond_to do |format|
      format.html { redirect_to user_root_url }
    end
  end

  def activate
    activated = UserTemplate.find_by_user_id_and_active(current_user.id, true)
    activated.update_attribute(:active, false)  if activated.present?
    new_active = UserTemplate.find_by_user_id_and_template_id(current_user.id, params[:id])
    new_active.update_attributes(active: true, last_activated_at: DateTime.now.utc, active_count: new_active.active_count + 1, color: params[:color])

    respond_to do |format|
      format.html { redirect_to user_root_url }
      format.json { render json: {} }
    end
  end

  private
    def set_template
      @template = Template.find(params[:id])
    end

    def template_params
      params.require(:template).permit(:user_id, :name, :style, :price, :colors, :image, :is_published, :formatted_file)
    end
end
