class User < ApplicationRecord
  before_save :downcase_email

  has_secure_password
  has_secure_password :remember, validations: false

  has_many :articles, dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 32 },
                   uniqueness: true,
                   format: { with: /\A[\w-]{,32}\z/ }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :introduction, length: { maximum: 140 }
  validates :password, length: { minimum: 8, maximum: 16 }, allow_nil: true

  has_one_attached :photo

  def to_param
    name
  end

  def remember_me
    self.remember = SecureRandom.urlsafe_base64
    save
  end

  def forget_me
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
