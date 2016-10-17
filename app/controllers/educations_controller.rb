class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_education, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @educations = current_user.educations
    respond_with(@educations)
  end

  def show
    respond_with(@education)
  end

  def new
    @education = Education.new
    respond_with(@education)
  end

  def edit
  end

  def create
    @education = Education.new(education_params)
    @education.user = current_user

    if @education.save
      flash.now[:success] = 'New education added successfully.'
    else
      flash.now[:error] = 'Failed to add new education information'
      add_error_messages(@education)
    end
    respond_with(@education)
  end

  def update
    @education.update(education_params)  if @education.user_id == current_user.id
    respond_with(@education)
  end

  def destroy
    @education.destroy  if @education.user_id == current_user.id
    respond_with(@education)
  end

  private
    def set_education
      @education = Education.find(params[:id])
    end

    def education_params
      params.require(:education).permit(:title, :institute, :location, :major, :result, :description, :start_date, :end_date, :current)
    end
end
