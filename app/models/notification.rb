class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit { NotificationBroadcastJob.perform_later(Notification.where(status: 0).size,self)}
end
