class Task < ApplicationRecord
  belongs_to :project_manager, class_name: 'User', foreign_key: 'project_manager_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id'
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id', dependent: :destroy
  belongs_to :parent_task, class_name: 'Task', optional: true
  belongs_to :project

  accepts_nested_attributes_for :subtasks
  validates :title, :description, :work_focus, :due_date, :status, presence: true

  enum statuses: {
    not_started: 'not_started',
    working: 'working',
    needs_review: 'needs_review',
    done: 'done',
    late: 'late'
  }
end
