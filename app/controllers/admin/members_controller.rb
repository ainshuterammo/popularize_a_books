class Admin::MembersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def index
    @members = Member.page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @member.update(member_params)
      redirect_to admin_members_path(@member)
    else
      render :edit
    end
  end

  private

  def find_user
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:is_deleted)
  end

end
