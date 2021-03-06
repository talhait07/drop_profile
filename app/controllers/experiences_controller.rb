class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @experiences = current_user.experiences
    respond_with(@experiences)
  end

  def show
    respond_with(@experience)
  end

  def new
    @experience = Experience.new
    respond_with(@experience)
  end

  def edit
  end

  def create
    @experience = Experience.new(experience_params)
    @experience.user = current_user

    if @experience.save
      flash.now[:success] = 'New experience added successfully.'
    else
      flash.now[:error] = 'Failed to add new experience'
      add_error_messages(@experience)
    end
    respond_with(@experience)
  end

  def update
    @experience.update(experience_params)  if @experience.user == current_user
    respond_with(@experience)
  end

  def destroy
    @experience.destroy  if @experience.user == current_user
    respond_with(@experience)
  end

  private
    def set_experience
      @experience = Experience.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:title, :company, :location, :designation, :description, :start_date, :end_date, :current)
    end
end
