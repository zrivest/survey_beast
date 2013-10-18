class User < ActiveRecord::Base
  has_many :surveys
  has_many :completed_surveys
  has_many :responses 
end
