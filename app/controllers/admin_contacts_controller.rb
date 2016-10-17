class AdminContactsController < ApplicationController
  before_action :admin_authorization, except: [:new, :create]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @contacts = AdminContact.all
    respond_with(@contacts)
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = AdminContact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
    @contact = AdminContact.new(contact_params)
    AdminContactMailer.contact(@contact, request.host).deliver

    if @contact.save

      flash.now[:success] = 'Thanks for submit your message.'
    else
      flash.now[:error] = 'Failed to submit the message.'
      add_error_messages(@contact)
    end
    respond_with(@contact)
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private
    def set_contact
      @contact = AdminContact.find(params[:id])
    end

    def contact_params
      params.require(:admin_contact).permit(:name, :email, :category, :title, :body)
    end
end
