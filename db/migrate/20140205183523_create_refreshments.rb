class CreateRefreshments < ActiveRecord::Migration

drop_table :beers

  def change
    create_table :refreshments do |t|
      t.text :name
      t.integer :abv
      t.integer :ibu

      t.timestamps
    end
  end
end
