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

  after_initialize :do_this_after_initialize

  def do_this_after_initialize
    unless ended_at.nil?
      if ended_at < Time.now
        update_attributes(recruiting: false)
      end
    else
      ended_at = Time.now
      update_attributes(ended_at: ended_at )
    end
  end

  def distance(longitude, latitude)
    @_longitude = longitude if @_longitude.nil?
    @_latitude = latitude if @_latitude.nil?

    if @_longitude != longitude || @_latitude != latitude || @_distance.nil?
      @_distance = ((location_longitude-longitude)**2 + (location_latitude - latitude)**2)**0.5
    end
    @_longitude = longitude
    @_latitude = latitude
    @_distance
  end

  def leader!(user)
    if participate?(user)
      participate_ins.find_by(user_id: user.id).update(leader: true)
    end
  end

  def leader
    leader_info = participate_ins.find_by(leader: true)
    users.find_by(id: leader_info.user_id) if !leader_info.nil?
  end

  def participate!(user)
    if participate_ins.length < self.user_limit && !participate?(user)
      participate_ins.create!(user_id: user.id, leader: false)
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

  def message_count
    microposts.count(:user_id)
  end

  def as_json(options = {})
    participants = {}
    users.each do |user|
      participants[user.id] = user
    end

    res = super(options)
    res[:leader] = leader
    res[:participants] = participants
    res # return res
  end

end