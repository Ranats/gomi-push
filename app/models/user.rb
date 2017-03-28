class User < ActiveRecord::Base
  has_many :gomis
  accepts_nested_attributes_for :gomis, allow_destroy: true
end
