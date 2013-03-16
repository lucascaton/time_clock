# == Schema Information
#
# Table name: punches
#
#  id         :integer          not null, primary key
#  origin_ip  :string(255)
#  punched_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Punch < ActiveRecord::Base
  attr_accessible :origin_ip, :punched_at

  validates :origin_ip, :punched_at, presence: true

  validates :punched_at, uniqueness: true

  after_create :remove_seconds_from_punched_at

  scope :by_date, lambda { |date| where(punched_at: date.beginning_of_day..date.end_of_day) }
  scope :ordered, order('punched_at DESC')

  private

  def remove_seconds_from_punched_at
    self.update_attributes punched_at: self.punched_at - self.punched_at.sec
  end
end
