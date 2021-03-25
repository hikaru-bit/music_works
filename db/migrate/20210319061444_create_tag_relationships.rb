class CreateTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relationships do |t|
      t.integer :post_id, foreign_key: true
      t.integer :tag_id, foreign_key: true

      t.timestamps
    end
      add_index :tag_relationships, [:post_id,:tag_id], unique: true
  end
end
