# encoding: utf-8
require 'factory_girl'
require 'forgery'

FactoryGirl.define do
  factory :punch do
    origin_ip  { '127.0.0.0' }
    punched_at { rand(8.hours.ago..Time.now) }
  end
end
