require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it 'has many tasks' do
      association = described_class.reflect_on_association(:tasks)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'validations' do

    let(:project_manager) { create(:user, :project_manager) }
    let(:employee) { create(:user, :employee) }

    it 'validates presence of title' do
      project = Project.new(description: 'Test description', due_date: Date.today)
      expect(project).not_to be_valid
      expect(project.errors[:title]).to include("can't be blank")
    end

    it 'allows the Project Manager to create projects' do
      project = Project.new(title: 'Test Project', description: 'Test Description', due_date: Date.today, project_manager_id: project_manager.id)
      expect(project).to be_valid
    end

    it 'validates presence of description' do
      project = Project.new(title: 'Test project', due_date: Date.today)
      expect(project).not_to be_valid
      expect(project.errors[:description]).to include("can't be blank")
    end

    it 'validates presence of due_date' do
      project = Project.new(title: 'Test project', description: 'Test description')
      expect(project).not_to be_valid
      expect(project.errors[:due_date]).to include("can't be blank")
    end
  end
end
