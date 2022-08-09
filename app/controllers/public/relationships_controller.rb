class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    member = member.find(params[:member_id])
    current_member.follow(member)
		redirect_to request.referer
  end

  def destroy
    member = member.find(params[:member_id])
    current_member.unfollow(member)
		redirect_to request.referer
  end

  def followings
    member = member.find(params[:member_id])
		@members = member.followings
  end

  def followers
    member = member.find(params[:member_id])
		@members = member.followers
  end

end


# ここに質問ある
  # def create
  #   current_member.follow(params[:member_id])
  #   redirect_to request.referer
  # end

  # def destroy
  #   current_member.unfollow(params[:member_id])
  #   redirect_to request.referer
  # end
