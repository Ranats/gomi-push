class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.time :pushtime, default:"06:00"
      t.string :title, default:"今日のゴミ"

      t.timestamps null: false
    end
  end
end
