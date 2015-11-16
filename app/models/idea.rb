class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :members, dependent: :destroy
  has_many :member_users, through: :members, source: :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :title, presence: true,
                    uniqueness: true

  def joined_by?(user)
    join_for(user).present?
  end

  def join_for(user)
    members.find_by_user_id(user.id)
  end

  def liked_by?(user)
    like_for(user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user.id)
  end

end
