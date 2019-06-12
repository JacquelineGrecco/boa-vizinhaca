# https://devcenter.heroku.com/articles/heroku-redis

module Neighbourhood
  # http://stackoverflow.com/questions/23962212/wrapping-sidekiqs-perform-method-to-add-timezone-awareness
  class SidekiqTimeZoneMiddleware
    attr_reader :timezone

    def initialize(timezone)
      @timezone = timezone
    end

    def call(worker, job, queue)
      Time.use_zone(timezone) { yield }
    end
  end
end

redis_config = {
    url: ENV.fetch("REDISTOGO_URL"),
    namespace: 'tcc',
    network_timeout: 5
}

Sidekiq.configure_server do |config|
  config.redis = redis_config

  # https://github.com/mperham/sidekiq/wiki/Middleware
  config.server_middleware do |chain|
    chain.add Neighbourhood::SidekiqTimeZoneMiddleware, "America/Sao_Paulo"
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end

def schedule(name, cron, worker_class, args: {})
  job = Sidekiq::Cron::Job.new name: name, cron: cron, class: worker_class, args: args
  raise job.errors.join("\n") unless job.save
end

if Sidekiq.server?
  schedule('E-mail notification - every first day of month at 00:01', '0 0 12 1 *', 'AllUsersNotificationWorker')
end
