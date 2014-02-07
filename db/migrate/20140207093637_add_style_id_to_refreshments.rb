class AddStyleIdToRefreshments < ActiveRecord::Migration
  def change
    add_column :refreshments, :style_id, :integer
  end
end
