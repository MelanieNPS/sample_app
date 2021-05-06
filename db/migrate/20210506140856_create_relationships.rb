class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    #Index for columns that are accessed frequently
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id

    #Enforces uniqueness on follower followed pairs. Cannot follow more than once
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
