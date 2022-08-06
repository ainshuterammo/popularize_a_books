class Book < ApplicationRecord

  belongs_to :member
  belongs_to :genre
  belongs_to :category

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  # validates :title,presence:true
  # validates :body,presence:true,length:{maximum:200}

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

end
