# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: {in: %w(APPROVED DENIED PENDING), message: "Invalid Status"}
  validate 
  belongs_to :cat

  #s_date = april 1st, e_date = april 31st
  #s_date = april 23rd, e_date = may 15th

  def overlapping_dates
    !CatRentalRequest.where.not(start_date: [self.start_date, self.end_date], end_date: [self.start_date, self.end_date]).empty?
  end
end
