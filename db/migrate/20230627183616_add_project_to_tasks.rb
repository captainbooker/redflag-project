class AddProjectToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :project, null: false, foreign_key: true
    add_reference :projects, :project_manager, foreign_key: { to_table: :users }
  end
end
