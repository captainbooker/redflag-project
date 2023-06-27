require 'rails_helper'

RSpec.describe TaskPolicy, type: :policy do
  let(:user) { create(:user, :employee) }
  let(:project_manager) { create(:user, :project_manager) }
  let(:assignee) { create(:user, :other_project_manager) }
  let(:project) { create(:project, project_manager: project_manager) }
  let(:task) { create(:task, project: project, assignee: assignee, project_manager: project_manager) }

  subject { described_class.new(user, task) }

  describe '#create?' do
    context 'when user is a project manager' do
      let(:user) { project_manager }

      it 'returns true' do
        expect(subject.create?).to be true
      end
    end

    context 'when user is not a project manager' do
      it 'returns false' do
        expect(subject.create?).to be false
      end
    end
  end
  
  describe '#destroy?' do
    context 'when assignee is project manager' do
      let(:assignee) { project_manager }

      it 'returns true' do
        expect(subject.destroy?).to be true
      end
    end

    context 'when assignee is not project manager' do
      it 'returns false' do
        expect(subject.destroy?).to be false
      end
    end
  end

  describe '#new?' do
    context 'when user is a project manager' do
      let(:user) { project_manager }

      it 'returns true' do
        expect(subject.new?).to be true
      end
    end

    context 'when user is not a project manager' do
      it 'returns false' do
        expect(subject.new?).to be false
      end
    end
  end
end
