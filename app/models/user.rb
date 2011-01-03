class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications
  # Setup accessible (or protected) attributes for your model

  def apply_omniauth(omniauth)
    self.email = omniauth['extra']['user_hash']['email'] if email.blank?
    authentications.build(:uid => omniauth['uid'], :token => omniauth['credentials']['token'] )
  end
  def followers()
    User.where(:follow_uid => self.authentications.first.uid)
  end
  attr_accessible :email, :password, :password_confirmation, :remember_me, :follow_uid
end
