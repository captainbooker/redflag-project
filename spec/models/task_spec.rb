require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it 'belongs to a project manager' do
      association = described_class.reflect_on_association(:project_manager)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:foreign_key]).to eq('project_manager_id')
    end

    it 'belongs to a project' do
      association = described_class.reflect_on_association(:project)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to an assignee' do
      association = described_class.reflect_on_association(:assignee)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.options[:foreign_key]).to eq('assignee_id')
    end

    it 'has many subtasks' do
      association = described_class.reflect_on_association(:subtasks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:foreign_key]).to eq('parent_task_id')
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'belongs to a parent task' do
      association = described_class.reflect_on_association(:parent_task)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:optional]).to be true
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:work_focus) }
    it { should validate_presence_of(:due_date) }
    it { should validate_presence_of(:status) }

    let(:project_manager) { create(:user, :project_manager) }
    let(:assignee) { create(:user, :employee) }
    let(:project) { create(:project, project_manager: project_manager) }

    context 'when assignee is the project manager' do
      let(:task) { create(:task, project_manager: project_manager, assignee: assignee, project: project, status: 'working') }

      it 'allows setting status to done' do
        task.status = 'done'
        task.reload
        expect(task).to be_valid
      end
    end

    it 'validates presence of title' do
      task = Task.new(description: 'Test description', due_date: Date.today)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'validates presence of description' do
      task = Task.new(title: 'Test task', due_date: Date.today)
      expect(task).not_to be_valid
      expect(task.errors[:description]).to include("can't be blank")
    end

    it 'validates presence of due_date' do
      task = Task.new(title: 'Test task', description: 'Test description')
      expect(task).not_to be_valid
      expect(task.errors[:due_date]).to include("can't be blank")
    end
  end
end
