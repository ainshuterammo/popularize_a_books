class Book < ApplicationRecord

  belongs_to :member
  belongs_to :genre

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum status: { public: 0, private: 1 }, _suffix: true

  validates :catchphrase, length:{maximum:50}
  validates :body, length:{maximum:250}

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
    favorites.exists?(member_id: member.id)
  end

  def self.search_for(content, method, column)
    if method == 'perfect'
      members =  Book.where("#{column} LIKE?","#{content}").where(status: :public)
      return members
    elsif method == 'forward'
      Book.where("#{column} LIKE ?", "#{content}" + '%').where(status: :public)
    elsif method == 'backward'
      Book.where("#{column} LIKE ?", '%' + "#{content}").where(status: :public)
    else
      Book.where("#{column} LIKE ?", '%' + "#{content}" + '%').where(status: :public)
    end
  end

end
