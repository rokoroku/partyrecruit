class ChengeStructures < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.string :description
      t.integer :user_limit
      t.float :location_longitude
      t.float :location_latitude
      t.boolean :recruiting

      t.timestamps
    end

    add_column :users, :username, :string
    add_column :users, :last_login, :date
    add_reference :microposts, :party, unique: true

    create_table :tags do |t|
      t.string :name
    end

    create_table :participate_in
    add_reference :participate_in, :user, index: true
    add_reference :participate_in, :party, index: true
    add_index :participate_in, [:user_id, :party_id], unique: true
    add_column :participate_in, :leader, :boolean

    create_table :has_tag
    add_reference :has_tag, :party, index: true
    add_reference :has_tag, :tag, index: true
    add_index :has_tag, [:party_id, :tag_id], unique: true
  end
end