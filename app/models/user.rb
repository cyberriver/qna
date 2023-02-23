class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :questions, foreign_key: :author_id, dependent: :destroy 
  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :rewards
  has_many :likes, dependent: :destroy

  def author_of?(resource)
    resource.author == self
  end

  def not_author_of?(resource)
    resource.author != self
  end

end
