class PostComment < ApplicationRecord

  belongs_to :member
  belongs_to :book

  validates :comment, presence: true, length:{maximum:50}

end
