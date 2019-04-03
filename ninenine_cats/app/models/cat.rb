# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  description :text             not null
#  sex         :string(1)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  COLORS = %w(brown red orange black white grey spotted green gold pink nyan)

  validates :birth_date, :color, :name, :description, :sex, presence: true
  validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    today = Date.today
    birth_date = self.birth_date
    yrs_old = today.year - birth_date.year
    birth_yday = birth_date.yday
    today_yday = today.yday
    yrs_old -= 1 if birth_yday > today_yday
    yrs_old
  end

  def self.colors
    COLORS
  end

end
