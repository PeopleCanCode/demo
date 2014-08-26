class Post < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 30 }
end
