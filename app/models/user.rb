class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_attached_file :image, styles: { medium: "500x500>", thumb: "250x250>" }, presence: true, default_url: "/assets/thumb/missing_avatar.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  has_many :posts, dependent: :destroy
  has_many :votes, dependent: :destroy
end
