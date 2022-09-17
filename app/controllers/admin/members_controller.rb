class Admin::MembersController < ApplicationController
  before_action :admin_signed_in, only: [:index, :show, :edit, :update]
  before_action :authenticate_admin!
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @members = Kaminari.paginate_array(Member.all.to_a).page(params[:page]).per(9)
  end

  # def show; end
  def show
    @books = Kaminari.paginate_array(@member.books.where(status: :public).to_a).page(params[:page]).per(6)
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to admin_members_path(@member)
    else
      render :edit
    end
  end

  private

  def admin_signed_in
    unless admin_signed_in?
      redirect_to new_admin_session_path
    end
  end

  def find_user
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:is_deleted)
  end

end
