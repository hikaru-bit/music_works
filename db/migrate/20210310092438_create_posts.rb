class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.integer :is_online
      t.string :state
      t.integer :is_recruitment
      t.integer :period
      t.integer :guarantee

      t.timestamps
    end
  end
end
