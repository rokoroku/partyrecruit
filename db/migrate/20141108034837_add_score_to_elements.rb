class AddScoreToElements < ActiveRecord::Migration
  def change
    add_column :parties, :score, :integer
    add_column :users, :score, :integer

    add_column :parties, :ended_at, :datetime
  end
end
