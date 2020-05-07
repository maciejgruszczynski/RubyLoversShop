class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts


  def has_cart?
    Cart.find_by(user_id: self.id).present?
  end

  def has_no_cart?
    Cart.fund_by(user_id: self.id).nil?
  end
end
