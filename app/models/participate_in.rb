class ParticipateIn < ActiveRecord::Base
  self.table_name = "participate_in"
  belongs_to :user
  belongs_to :party
  validates :party_id, presence: true
  validates :user_id, presence: true
end