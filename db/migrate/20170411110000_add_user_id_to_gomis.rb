class AddUserIdToGomis < ActiveRecord::Migration
  def change
    add_column :gomis, :user_id, :integer
  end
end
