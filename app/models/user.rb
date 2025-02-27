class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable, :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :blog_posts, foreign_key: "author_id", dependent: :destroy
end
