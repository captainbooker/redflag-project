require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_inclusion_of(:role).in_array(%w(admin manager employee)) }
  end

  describe 'associations' do
    it 'has many created tasks' do
      association = described_class.reflect_on_association(:created_tasks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:foreign_key]).to eq('project_manager_id')
    end

    it 'has many assigned tasks' do
      association = described_class.reflect_on_association(:assigned_tasks)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Task')
      expect(association.options[:foreign_key]).to eq('assignee_id')
    end
  end

  describe 'role methods' do
    let(:user) { User.new(role: 'admin') }

    it 'returns true if the user is an admin' do
      expect(user.admin?).to be true
    end

    it 'returns false if the user is not an admin' do
      expect(user.project_manager?).to be false
    end
  end

  describe 'authorization' do
    let(:project_manager) { build_stubbed(:user, role: 'project_manager') }
    let(:employee) { build_stubbed(:user, role: 'employee') }

    context 'project manager' do
      it 'can create employees' do
        policy = UserPolicy.new(project_manager, nil)
        expect(policy.create_employee?).to be true
      end
    end

    context 'employee' do
      it 'cannot create employees' do
        policy = UserPolicy.new(employee, nil)
        expect(policy.create_employee?).to be false
      end
    end
  end
end
