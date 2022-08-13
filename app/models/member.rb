class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(last_name: 'guestmember' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照一覧→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def follow(member)
    relationships.create(followed_id: member.id)
  end

  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def self.search_for(content, method, column)
    if method == 'perfect'
      members =  Member.where("#{column} LIKE?","#{content}")
      return members
    elsif method == 'forward'
      Member.where("#{column} LIKE ?", "#{content}" + '%')
    elsif method == 'backward'
      Member.where("#{column} LIKE ?", '%' + "#{content}")
    else
      Member.where("#{column} LIKE ?", '%' + "#{content}" + '%')
    end
  end

end


# 'title LIKE(?) OR explanation LIKE(?) OR animal_name LIKE(?)',
# def self.looks(search,word)
#     if search == "perfect_match"
#       @user = User.where("name LIKE?","#{word}")
#     elsif search == "forward_match"
#       @user = User.where("name LIKE?","#{word}%")
#     elsif search == "backward_match"
#       @user = User.where("name LIKE?","%#{word}")
#     elsif search == "partial_match"
#       @user = User.where("name LIKE?","%#{word}%")
#     else
#       @user = User.all
#     end
#   end
