class User < ActiveRecord::Base
  has_many :gomis, dependent: :destroy
  accepts_nested_attributes_for :gomis, allow_destroy:true
end
