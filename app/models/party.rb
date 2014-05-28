class Party < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :participate_ins, dependent: :destroy
  has_many :has_tags, dependent: :destroy

  has_many :users, through: :participate_ins
  has_many :tags, through: :has_tags

end