class AddProjectManagerToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :project_manager, foreign_key: { to_table: :users }
    add_reference :tasks, :assignee, foreign_key: { to_table: :users }
  end
end
