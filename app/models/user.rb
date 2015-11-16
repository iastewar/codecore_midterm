class User < ActiveRecord::Base
  has_secure_password

  has_many :ideas, dependent: :nullify
  has_many :comments, dependent: :nullify

  has_many :members, dependent: :destroy
  has_many :member_ideas, through: :members, source: :idea

  has_many :likes, dependent: :destroy
  has_many :liking_ideas, through: :likes, source: :idea
end
