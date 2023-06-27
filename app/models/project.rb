class Project < ApplicationRecord
  has_many :tasks
  belongs_to :project_manager, class_name: 'User', foreign_key: 'project_manager_id'

  validates :title, :description, :due_date, presence: true
end
  