class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
	t.column :name, :string
	t.column :created_at, :timestamp
    end
    Extension.create :name => "jpeg"
    Extension.create :name => "JPEG"
    Extension.create :name => "jpg"
    Extension.create :name => "JPG"
    Extension.create :name => "gif"
    Extension.create :name => "GIF"
    Extension.create :name => "png"
    Extension.create :name => "PNG"
  end

  def self.down
    drop_table :extensions
  end
end
