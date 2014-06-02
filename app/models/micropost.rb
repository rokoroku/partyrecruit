class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :party
  default_scope -> { order('created_at DESC') }

  validates :party_id,
            presence: true,
            length: {maximum: 50}

  validates :content,
            presence: true,
            length: {maximum: 200}

end
