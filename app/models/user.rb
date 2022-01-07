class User < ApplicationRecord
  include ActionController::Helpers
  mount_uploader :image, ImageUploader
    has_secure_password
    has_one :user_detail, dependent: :destroy
    has_many :funnels, dependent: :destroy
    helper_method :email_activate
    accepts_nested_attributes_for :user_detail
    #before_create :confirmation_token
    after_create_commit { notify }
#Basic password validation, configure to your liking.
  validates_length_of       :password, maximum: 72, minimum: 4, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

 
  # Make sure email and username are present and unique.
  validates :email, presence: true     
  validates :f_name, presence: true
  validates_uniqueness_of   :email

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  #token for password reset
  def generate_password_token!
    self.password_reset_token = generate_token
    save!
   end

 
  private
  #NOTIFICATION on new user


  def notify
    Notification.create(event: "New User #{self.f_name} #{self.l_name}",user_id: self.id ,status: 0)
  end
  #token for email confirm
  # def confirmation_token
  #     if self.confirm_token.blank?
  #         self.confirm_token = SecureRandom.urlsafe_base64.to_s
  #     end
  # end

   def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
   end

  # def reset_password!(password)
  #   self.password_reset_token = nil
  #   self.password = password
  #   save!
  #  end
   
   def generate_token
    SecureRandom.hex(10)
   end
end
