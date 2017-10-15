class Address < ApplicationRecord

    belongs_to :user

    validates :recipient,
              presence: true,
              length: { within: 3..32 }

    validates :organisation,
              length: { within: 3..32 }

    validates :line_one, :town,
              presence: true,
              length: { within: 3..64 }

    validates :line_two,
              length: { within: 3..64 }

    validates :postcode,
              length: { is: 6 },
              format: {
                  with: /\A([A-Z][A-Z0-9]?[A-Z0-9]?[A-Z0-9]?[0-9][A-Z0-9]{2})\z/,
                  message: I18n.t('invalid_postcode')
              }

end
