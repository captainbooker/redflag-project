require 'rails_helper'

RSpec.describe ProjectPolicy, type: :policy do
  let(:user) { create(:user, :employee) }
  let(:project_manager) { create(:user, :project_manager) }
  let(:project) { create(:project, project_manager: project_manager) }

  subject { described_class }

  permissions :create?, :new?, :edit?, :destroy? do
    context 'when user is a project manager' do
      let(:user) { project_manager }

      it 'grants access' do
        expect(subject).to permit(user, project)
      end
    end

    context 'when user is not a project manager' do
      it 'denies access' do
        expect(subject).not_to permit(user, project)
      end
    end
  end
end
