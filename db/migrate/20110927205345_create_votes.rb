class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|

      t.timestamps
      t.references :users
      t.references :posts
    end
  end

  def self.down
    drop_table :votes
  end
end
