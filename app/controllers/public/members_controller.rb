class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :show]
  before_action :ensure_correct_member, only: [:edit, :update]

  def show
    @member = Member.find(params[:id])
    @books = @member.books
    @book = Book.new
  end

  def index
    @members = Member.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "正常に更新できました"
    else
      render "edit"
    end
  end

  def favorites
    @member = Member.find(params[:id])
    favorites= Favorite.where(member_id: @member.id).pluck(:book_id)
    @favorite_books = Book.find(favorites)
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :nick_name, :self_introduction, :is_deleted, :profile_image)
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.full_name == "guestmember"
      redirect_to member_path(current_member) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

end
