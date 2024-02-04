require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    SidekiqScheduler::Scheduler.reload_schedule!
  end
end