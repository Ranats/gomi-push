class CreateGomis < ActiveRecord::Migration
  def change
    create_table :gomis do |t|
      t.string :name
      t.boolean :every
      t.boolean :fortnightly
      t.integer :start_date
      t.boolean :mon
      t.boolean :tues
      t.boolean :wed
      t.boolean :thurs
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun

      t.timestamps null: false
    end
  end
end
