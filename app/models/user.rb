class User < ApplicationRecord
  has_many :players

  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:discord]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.uid + "@gw2rank.com"
      user.password = Devise.friendly_token[0, 20]
      user.discord_name = auth.info.name   # assuming the user model has a name
      user.image_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
