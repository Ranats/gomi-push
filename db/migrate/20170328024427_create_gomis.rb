class CreateGomis < ActiveRecord::Migration
  def change
    create_table :gomis do |t|
      t.string :name
      t.integer :every
#      t.boolean :fortnightly
      t.string :start_date
      t.integer :mon
      t.integer :tues
      t.integer :wed
      t.integer :thurs
      t.integer :fri
      t.integer :sat
      t.integer :sun

      t.timestamps null: false
    end
  end
end
