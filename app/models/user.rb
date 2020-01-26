class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
  include DeviseTokenAuth::Concerns::User

  enum status:{nonreleased: 0, released: 1}
end