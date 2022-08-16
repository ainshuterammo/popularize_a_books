class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(name: 'guestmember' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guest"
      member.nick_name = "guest"
      member.self_introduction = "guestです、よろしくお願いします"
      member.is_deleted = "false"
    end
  end

  has_one_attached :profile_image
  
  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  validates :name, presence: true
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