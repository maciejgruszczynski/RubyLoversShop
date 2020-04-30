class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts


  def user_has_cart?(user_id)
    Cart.find_by(user_id: user_id).present?
  end

  def user_has_no_cart?(user_id)
    Cart.fund_by(user_id: user_id).nil?
  end

  def has_cart?
    Cart.find_by(user_id: self.id).present?
  end

  def has_no_cart?
    Cart.find_by(user_id: self.id).nil?
  end
end
