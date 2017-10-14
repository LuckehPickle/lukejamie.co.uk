class User < ApplicationRecord

    devise :database_authenticatable, :registerable,
           :confirmable, :recoverable, :rememberable, :trackable, :validatable

    has_many :orders,    dependent: :destroy
    has_many :addresses, dependent: :destroy

end
