class NotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :notification, retry: 5

  def perform(args)
    user = User.find args['user_id']
    method = args['method'] || 'notify_user_about_neighbour'

    ApplicationMailer.send(method, user)
  end
end