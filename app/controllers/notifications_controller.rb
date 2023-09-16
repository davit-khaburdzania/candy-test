class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_notification, only: [:set_seen]

  def set_seen
    if @notification.update(seen: true)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def find_notification
    @notification = Notification.find(params[:id])
  end
end
