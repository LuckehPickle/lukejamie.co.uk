class User < ApplicationRecord

    devise :database_authenticatable, :registerable,
           :confirmable, :recoverable, :rememberable, :trackable, :validatable

    has_many :orders,    dependent: :destroy
    has_many :addresses, dependent: :destroy

    enum role: [ :customer, :admin ]

    validates :role, presence: true

    validates :name,
              presence: true,
              length: { within: 3..64 }

    default_scope { order(updated_at: :desc) }

end
