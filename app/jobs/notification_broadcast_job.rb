class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(counter,notification)
    ActionCable.server.broadcast 'notifications_channel',  counter: render_counter(counter), notification: render_notification(notification)
  end

  private

  def render_counter(counter)
    ApplicationController.renderer.render(partial: 'admin/notifications/counter', locals: { counter: counter })
  end

  def render_notification(notification)
    ApplicationController.renderer.render(partial: 'admin/notifications/notification', locals: { notification: notification })
  end
end
