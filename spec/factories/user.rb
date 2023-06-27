FactoryBot.define do
  factory :user do
    trait :admin do
      email { 'admin@example.com' }
      password { 'password123' }
      role { 'admin' }
    end

    trait :employee do
      email { 'employee@example.com' }
      password { 'password123' }
      role { 'employee' }
    end

    trait :project_manager do
      email { 'project_manager@example.com' }
      password { 'password123' }
      role { 'project_manager' }
    end

    trait :other_project_manager do
      email { 'other_project_manager@example.com' }
      password { 'password123' }
      role { 'project_manager' }
    end
  end
end
