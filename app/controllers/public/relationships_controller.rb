class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member)
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member)
  end

  def followings
    member = Member.find(params[:member_id])
		@members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
		@members = member.followers
  end

end