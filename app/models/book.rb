class Book < ApplicationRecord

  belongs_to :member
  belongs_to :genre

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # validates :title,presence:true
  # validates :body,presence:true,length:{maximum:200}

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
    favorites.exists?(member_id: member.id)
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     Book.where(title: content)
  #   elsif method == 'forward'
  #     Book.where('title LIKE ?', content+'%')
  #   elsif method == 'backward'
  #     Book.where('title LIKE ?', '%'+content)
  #   else
  #     Book.where('title LIKE ?', '%'+content+'%')
  #   end
  # end
  
  def self.search_for(content, method, column)
    if method == 'perfect'
      members =  Book.where("#{column} LIKE?","#{content}")
      return members
    elsif method == 'forward'
      Book.where("#{column} LIKE ?", "#{content}" + '%')
    elsif method == 'backward'
      Book.where("#{column} LIKE ?", '%' + "#{content}")
    else
      Book.where("#{column} LIKE ?", '%' + "#{content}" + '%')
    end
  end

end
