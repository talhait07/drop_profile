class LanguagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    # @languages = current_user.languages
    respond_with(@languages)
  end

  def show
    respond_with(@language)
  end

  def new
    @language = Language.new
    respond_with(@language)
  end

  def edit
    respond_with(@language)
  end

  def create
    @language = Language.new(language_params)
    @language.user = current_user
    @language.save
  end

  def update
    @language.update(language_params)   if @language.user_id == current_user.id
  end

  def destroy
    @language.destroy   if @language.user_id == current_user.id
  end

  private
    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name, :listening_level, :writing_level, :speaking_level)
    end
end
