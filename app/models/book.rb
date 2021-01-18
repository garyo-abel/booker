class Book < ApplicationRecord
  validates :title, presence: true
  validates :opinion, presence: true, length: { maximum: 200, too_long: '最大200文字まで入力できます'}
  belongs_to :user
end
