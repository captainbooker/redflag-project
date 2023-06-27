require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'Task Due Date Check',
  cron: '0 0 * * *',
  class: 'TaskDueDateWorker'
)