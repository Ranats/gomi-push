class Gomi < ActiveRecord::Base
  belongs_to :user
  # バリデーション
  # 値が存在　: true
  validates :name, :every, :user_id, presence: true

  # 条件付き
  validates :start_date, presence: true, if: :fortnightly?

  def fortnightly?
    every == 2
  end

  # カスタムバリデーション
  validate :select_one_day_of_the_week

  def select_one_day_of_the_week
    if mon + tues + wed + thurs + fri + sat + sun == 0
      errors.add(:曜日,":1つ以上の曜日を選択してください．")
    end
  end

  def push
    p "push!!!!!!!!!!!!!!!!!!!!!!!!"
  end

end
