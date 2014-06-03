class AddStatusMsgToParticipateIn < ActiveRecord::Migration
  def change
    add_column :participate_in, :status_msg, :string
    add_column :microposts, :type, :integer
  end
end
