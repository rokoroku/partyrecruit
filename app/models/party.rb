class Party < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :participate_ins, dependent: :destroy
  has_many :has_tags, dependent: :destroy

  has_many :users, through: :participate_ins
  has_many :tags, through: :has_tags
  validates :name,
            presence: true,
            length: {maximum: 50}

  validates :description,
            presence: true,
            length: {maximum: 50}

  validates :user_limit,
            presence: true

  def leader!(user)
    if participate?(user)
      participate_ins.find_by(user_id: user.id).update(leader: true)
    end
  end

  def leader()
    users.find_by(id: participate_ins.find_by(leader: true).user_id)
  end

  def participate!(user)
    if participate_ins.length < self.user_limit && !participate?(user)
        participate_ins.create!(user_id: user.id, leader:false)
    else
      false
    end
  end

  def participate?(user)
    !participate_ins.find_by(user_id: user.id).nil?
  end

  def leave!(user)
    participate_ins.find_by(user_id: user.id).destroy
  end

  def as_json(options = { })
    participants = {}
    users.each do |user|
      participants[user.id] = user
    end

    res = super(options)
    res[:leader] = leader
    res[:participants] = participants
    res  # return res
  end

end