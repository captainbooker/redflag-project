class TaskDueDateWorker
  include Sidekiq::Worker

  def perform
    tasks = Task.where("due_date < ?", Date.today).where.not(status: 'late')
    tasks.update_all(status: 'late')
  end
end