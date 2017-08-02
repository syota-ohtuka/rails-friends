class User < ApplicationRecord
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true

	# 開発終わったらformat: { with: VALID_EMAIL_REGEX }追加
	validates :email, presence: true, uniqueness: true

	# 開発終わったらlength: { minimum: 8 }追加
  validates :password, presence: true
end
