class Punch < ActiveRecord::Base
  attr_accessible :origin_ip, :punched_at

  validates :origin_ip, :punched_at, presence: true

  validates :punched_at, uniqueness: true

  after_create :remove_seconds_from_punched_at

  scope :by_date, lambda { |date| where(punched_at: date.beginning_of_day..date.end_of_day) }
  scope :ordered, order('punched_at DESC')

  def self.worked_time(date = nil)
    TimeConverter.new(self.worked_time_in_seconds(date)).to_time
  end

  def self.worked_time_balance(date = nil)
    balance_in_seconds = self.worked_time_balance_in_seconds(date)
    balance = TimeConverter.new(balance_in_seconds.abs).to_time

    return "- #{balance}" if balance_in_seconds > 0
    return "+ #{balance}" if balance_in_seconds < 0
    'OK'
  end

  private

  def remove_seconds_from_punched_at
    self.update_attributes punched_at: self.punched_at - self.punched_at.sec
  end

  def self.worked_time_in_seconds(date = nil)
    punches = date.present? ? self.by_date(date).ordered : self.ordered

    seconds = []
    punches.reverse.each_slice(2) do |start_time, end_time|
      seconds << ((end_time.try(:punched_at) || Time.now) - start_time.punched_at)
    end

    seconds.sum.to_i
  end

  def self.worked_time_balance_in_seconds(date = nil)
    daily_work_in_seconds = Settings.daily_work_hours * 3600

    if date
      daily_work_in_seconds - self.worked_time_in_seconds(date)
    else
      worked_days = self.ordered.map{ |punch| punch.punched_at.to_date }.uniq.count
      worked_days * daily_work_in_seconds - self.worked_time_in_seconds
    end
  end
end
