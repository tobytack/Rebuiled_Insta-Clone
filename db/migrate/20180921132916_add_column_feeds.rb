class AddColumnFeeds < ActiveRecord::Migration[5.1]
  def change
    add_column :feeds, :image, :text
    add_column :feeds, :created_at, :datetime, null: false
    add_column :feeds, :updated_at, :datetime, null: false
  end
end
