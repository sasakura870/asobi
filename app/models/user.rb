class User < ApplicationRecord
  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password
  has_secure_password :remember, validations: false
  has_secure_password :activation, validations: false

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :comments, dependent: :destroy
  has_many :comment_articles, through: :comments, source: :article
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: :following_id,
                                  dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: :follower_id,
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  validates :name, presence: true,
                   length: { in: 4..16 },
                   uniqueness: true,
                   format: { with: /\A[\w]{4,16}\z/ }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :introduction, length: { maximum: 140 }
  validates :password, length: { in: 8..72 },
                       format: { with: /\A[\w-]{8,72}\z/ },
                       allow_nil: true
  validates :nick_name, length: { maximum: 50 }

  enum status: { temporary: 0,
                 register: 1,
                 admin: 2 }

  has_one_attached :photo

  def to_param
    name
  end

  def signup_activation
    # update_column(:activated, true)
    register! if temporary?
  end

  def remember_me
    self.remember = SecureRandom.urlsafe_base64
  end

  def forget_me
    update_column(:remember_digest, nil)
  end

  def already_favorite?(article)
    favorites.exists?(article_id: article.id)
  end

  def my_comment?(comment)
    comments.exists?(id: comment.id)
  end

  def already_follow?(user)
    followings.include?(user)
  end

  def followed_by?(user)
    followers.include?(user)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation = SecureRandom.urlsafe_base64
  end
end
