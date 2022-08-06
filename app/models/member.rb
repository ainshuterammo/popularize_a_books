class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(last_name: 'guestuser' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "guestuser"
    end
  end

  has_many :books



  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  has_one_attached :profile_image

  def full_name
    last_name + first_name
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def follow(member)
    relationships.create(followed_id: member.id)
  end

  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     User.where(name: content)
  #   elsif method == 'forward'
  #     User.where('name LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     User.where('name LIKE ?', '%' + content)
  #   else
  #     User.where('name LIKE ?', '%' + content + '%')
  #   end
  # end

end
