class Message < ActiveRecord::Base
  belongs_to :user
  has_many :message_permissions
end
