class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
  end

  def show
    respond_with(@skill)
  end

  def new
    @skill = Skill.new
    respond_with(@skill)
  end

  def edit
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    @skill.save
  end

  def update
    @skill.update(skill_params)  if @skill.user_id == current_user.id
  end

  def destroy
    @skill.destroy  if @skill.user_id == current_user.id
  end

  private
    def set_skill
      @skill = Skill.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :level, :match)
    end
end
