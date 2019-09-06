class User < ApplicationRecord
  before_save :downcase_email

  has_secure_password

  validates :name, presence: true,
                   length: { maximum: 32 },
                   uniqueness: true,
                   format: { with: /\A[\w-]{,32}\z/ }
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :introduction, length: { maximum: 140 }
  validates :password, length: { minimum: 8, maximum: 16 }, allow_nil: true

  mount_uploader :photo, PhotoUploader

  # def photo_resize(size)
  #   photo(resize: "#{size}x#{size}").process
  # end

  private

  def downcase_email
    self.email = email.downcase
  end
end
