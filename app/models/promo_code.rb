class PromoCode < ApplicationRecord

    self.primary_key = 'code'

    default_scope { order(updated_at: :desc) }

    validates :code,
              presence: true,
              uniqueness: true,
              length: { within: 5..16 },
              format: {
                  with: /\A[A-Z0-9]+\z/,
                  message: 'must be alpha numeric.'
              }

    validates :label,
              presence: true,
              length: { maximum: 128 }

    validates :discount,
              presence: true,
              numericality: {
                  only_integer: true,
                  greater_than_or_equal_to: 0,
                  less_than_or_equal_to: 100
              }

    validates :start_date, :finish_date,
              presence: true

    validate :finish_date_after_start_date


    before_validation do
        self.code.upcase!
    end


    ##
    # Ensures that the finish date is after the starting date.
    def finish_date_after_start_date
        if start_date.present? and finish_date.present?
            if finish_date < start_date
                errors.add(:finish_date, t('finish_after_start_date'))
            end
        end
    end


    ##
    # Determines whether this promo code is currently active.
    def active?
        Time.now >= start_date.at_beginning_of_day and
            Time.now <= finish_date.at_end_of_day
    end


    ##
    # Returns a percentage representing how long a promo code
    # has been active for.
    def percentage
        total = finish_date.at_end_of_day - start_date.at_beginning_of_day
        current = Time.now - start_date.at_beginning_of_day
        (current / total) * 100
    end

end
