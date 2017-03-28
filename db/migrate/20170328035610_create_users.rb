class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :pushtime_h
      t.integer :pushtime_m

      t.timestamps null: false
    end
  end
end
