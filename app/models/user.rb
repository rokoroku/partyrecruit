# coding UTF-8
class User < ActiveRecord::Base

  # Relationship
  has_many :microposts, foreign_key: "user_id", dependent: :destroy
  has_many :participate_in, foreign_key: "user_id", dependent: :destroy
  has_many :parties, through: :participate_in, class_name: "Party", source: :party

  # Active Record Callback 함수
  before_save { email.downcase! }
  before_create { :create_remember_token }

  # Attribute data 검증 함수
  validates :name,
            presence: true,
            length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  # / start of regex
  # \A match start of a string
  # [\w+\-.]+ at least one word character, plus, hyphen, or dot
  # @ literal “at sign”
  # [a-z\d\-.]+ at least one letter, digit, hyphen, or dot
  # \. literal dotf
  # [a-z]+ at least one letter
  # \z match end of a string
  # / end of regex
  # i case insensitive
  validates :email,
            presence: true,
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password,
            length: {minimum: 6}

  validate :password_confirmation,
           presence: true

  # 랜덤 token 생성 함수
  def User.new_random_token
    SecureRandom.urlsafe_base64
  end

  # token 해싱 함수
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def status_msg(party)
    participate_info = participate_in.find_by(party_id: party.id)
    participate_info.status_msg if !participate_info.nil?
  end

  def participate_info(party)
    participate_in.find_by(party_id: party.id)
  end

  # json 변환 함수 override
  def as_json(options = { })
    json = super({:only => [:id, :name]}.merge(options))
    json[:hash] = Digest::MD5::hexdigest(email.downcase)
    json
  end

  private
  # Session 유지 token 생성 함수
  def create_remember_token
    self.remember_token = User.digest(User.new_random_token)
  end
end
