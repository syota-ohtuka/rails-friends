class User < ApplicationRecord
	has_many :follows_from, class_name: Friend, foreign_key: :from_user_id, dependent: :destroy
	has_many :follows_to,   class_name: Friend, foreign_key: :to_user_id,   dependent: :destroy
	has_many :following, through: :follows_from, source: :to_user
	has_many :followed,  through: :follows_to,   source: :from_user
	has_many :voices, dependent: :destroy
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true

	# 開発終わったらformat: { with: VALID_EMAIL_REGEX }追加
	validates :email, presence: true, uniqueness: true

	# 開発終わったらlength: { minimum: 8 }追加
  validates :password, presence: true

  validates :search_word, presence: true, uniqueness: true

  # 指定ユーザをフォローしているかどうかを返す
	def following?(user)
		self.following.where(id: user.id).any?
	end

	# 指定ユーザにフォローされているかどうかを返す
	def followed_by?(user)
		self.followed.where(id: user.id).any?
	end
end
