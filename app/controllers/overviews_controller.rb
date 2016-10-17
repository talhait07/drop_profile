class OverviewsController < ApplicationController
  before_action :set_overview, only: [:show, :edit, :update, :destroy]

  respond_to :html
  respond_to :js, only: [:update]

  def index
    @overviews = Overview.all
    respond_with(@overviews)
  end

  def show
    respond_with(@overview)
  end

  def new
    @overview = Overview.new
    respond_with(@overview)
  end

  def edit
  end

  def create
    @overview = Overview.new(overview_params)
    @overview.save
    respond_with(@overview)
  end

  def update
    if @overview.update(overview_params)
      flash.now[:success] = 'Objective updates successfully.'
    else
      flash.now[:error] = 'Objective updates failed.'
      add_error_messages(@overview)
    end
    respond_with(@overview)
  end

  def destroy
    @overview.destroy
    respond_with(@overview)
  end

  private
    def set_overview
      @overview = Overview.find(params[:id])
    end

    def overview_params
      params.require(:overview).permit(:user_id, :objective, :cover_letter)
    end
end
