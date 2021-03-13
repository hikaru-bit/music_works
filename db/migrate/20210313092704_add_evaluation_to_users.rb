class AddEvaluationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :evaluation, :float
  end
end
