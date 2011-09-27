class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :description , :null => false , :default=>""
      t.integer :parent , :default=>-1
      t.integer :num_of_votes  , :default=>0 , :null=>false

      t.timestamps
      t.references :users
    end
  end

  def self.down
    drop_table :posts
  end
end
