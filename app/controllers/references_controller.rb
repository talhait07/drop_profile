class ReferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reference, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    # @references = current_user.references
    respond_with(@references)
  end

  def show
    respond_with(@reference)
  end

  def new
    @reference = Reference.new
    respond_with(@reference)
  end

  def edit
  end

  def create
    @reference = Reference.new(reference_params)
    @reference.user = current_user

    if @reference.save
      flash.now[:success] = 'New reference added successfully.'
    else
      flash.now[:error] = 'Failed to add new reference information'
      add_error_messages(@reference)
    end
    respond_with(@reference)
  end

  def update
    @reference.update(reference_params)   if @reference.user_id == current_user.id
    respond_with(@reference)
  end

  def destroy
    @reference.destroy   if @reference.user_id == current_user.id
    respond_with(@reference)
  end

  private
    def set_reference
      @reference = Reference.find(params[:id])
    end

    def reference_params
      params.require(:reference).permit(:name, :designation, :company, :location, :email, :phone)
    end
end
