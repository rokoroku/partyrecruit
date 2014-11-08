class AddCategoryToParties < ActiveRecord::Migration
  def change
    add_column :parties, :category, :integer
  end
end
