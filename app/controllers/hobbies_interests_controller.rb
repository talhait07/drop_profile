class HobbiesInterestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hobbies_interest, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
  end

  def show
    respond_with(@hobbies_interest)
  end

  def new
    @hobbies_interest = HobbiesInterest.new
    respond_with(@hobbies_interest)
  end

  def edit
  end

  def create
    hobbies = hobbies_interest_params[:title]
    hobbies = hobbies.split(',').map(&:strip)
    hobbies.each do |hobby|
      HobbiesInterest.create(title: hobby, user_id: current_user.id)
    end
    current_user.reload
    respond_with(@hobbies_interest)
  end

  def update
    @hobbies_interest.update(hobbies_interest_params) if @hobbies_interest.user_id == current_user.id
    respond_with(@hobbies_interest)
  end

  def destroy
    @hobbies_interest.destroy   if @hobbies_interest.user_id == current_user.id
    respond_with(@hobbies_interest)
  end

  private
    def set_hobbies_interest
      @hobbies_interest = HobbiesInterest.find(params[:id])
    end

    def hobbies_interest_params
      params.require(:hobbies_interest).permit(:user_id, :title)
    end
end
