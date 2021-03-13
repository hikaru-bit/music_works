class RemoveRateFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :rate, :float
  end
end
