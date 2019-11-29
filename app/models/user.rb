class User < ApplicationRecord
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
  has_many :tag_maps, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_maps

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
                 admin: 2,
                 guest: 3 }

  has_one_attached :photo

  scope :allowed, -> { register.or(guest) }

  def to_param
    name
  end

  def allowed?
    register? || guest?
  end

  def signup
    register! if temporary?
  end

  def remember_me
    self.remember = SecureRandom.urlsafe_base64
    save
  end

  def forget_me
    update_column(:remember_digest, nil)
  end

  def already_favorite?(article)
    favorites.exists?(article_id: article.id)
  end

  def activation_mail_expired?
    send_activation_mail_at < 1.day.ago
  end

  def deactivate
    self.status = :temporary
    self.activation = SecureRandom.urlsafe_base64
    self.send_activation_mail_at = Time.zone.now
    save
  end

  def attach_base64_photo(image)
    photo.purge if photo.attached?

    content_type = grep_content_type image
    contents = grep_contents image
    decoded_data = Base64.decode64 contents
    photo.attach(
      io: StringIO.new(decoded_data),
      filename: "#{Time.current.to_i}.#{content_type}",
      content_type: "image/#{content_type}"
    )
  end

  private

  def grep_content_type(image)
    image_type = image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
    image_type[%r{\b(?!.*\/).*}]
  end

  def grep_contents(image)
    image.sub %r/data:((image|application)\/.{3,}),/, ''
  end
end
