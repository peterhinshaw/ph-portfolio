class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.string :from_email
      t.string :to_email
      t.integer :article_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
