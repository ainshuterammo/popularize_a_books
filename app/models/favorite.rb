class Favorite < ApplicationRecord

  belongs_to :member
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :member_id

end
