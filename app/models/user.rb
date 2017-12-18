class User < ApplicationRecord

    devise :database_authenticatable, :registerable,
           :confirmable, :recoverable, :rememberable, :trackable, :validatable

    searchkick callbacks: :async

    def search_data
        {
            name: name,
            email: email,
            role: role,
            updated_at: updated_at
        }
    end

    has_many :orders,    dependent: :destroy
    has_many :addresses, dependent: :destroy

    enum role: [ :customer, :admin ]

    validates :role, presence: true

    validates :name,
              presence: true,
              length: { within: 3..64 }

end
