class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :role, inclusion: { in: %w(admin manager employee project_manager) }

  has_many :created_tasks, class_name: 'Task', foreign_key: 'project_manager_id'
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def employee?
    role == 'employee'
  end

  def project_manager?
    role == 'project_manager'
  end
end
