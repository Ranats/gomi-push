class User < ActiveRecord::Base
  has_many :gomis, dependent: :destroy
  accepts_nested_attributes_for :gomis, allow_destroy:true

  # 一意性(ユニーク) : uniqueness: true
  validates :name, uniqueness:true
  validates_uniqueness_of :name

end
