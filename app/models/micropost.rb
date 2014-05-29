class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :party
  default_scope -> { order('created_at DESC') }

end
