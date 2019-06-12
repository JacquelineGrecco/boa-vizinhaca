class AllUsersNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :notification, retry: 5

  def perform(_args)
    User.ids.each { |id| NotificationWorker.perform_async({'user_id' => id}) }
  end
end