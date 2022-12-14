class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit]
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]

  def show
    @member = Member.find(params[:id])
    @books = if current_member == @member
        Kaminari.paginate_array(current_member.books.to_a).page(params[:page]).per(6)
      else
        Kaminari.paginate_array(@member.books.where(status: :public).to_a).page(params[:page]).per()
      end
    @book = Book.new
  end

  def index
    @book = Book.new
    @members = Member.where(is_deleted: :false).page(params[:page]).per(9)
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

  def unsubscribe
  end

  def withdraw
    current_member.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guest"
      redirect_to member_path(current_member.id) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member.id)
    end
  end

  def member_params
    params.require(:member).permit(:name, :nick_name, :self_introduction, :is_deleted, :profile_image)
  end

end
