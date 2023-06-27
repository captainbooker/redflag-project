FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    work_focus { "MyString" }
    due_date { "2023-06-27" }
    status { "needs_review" }
    project_manager { nil }
  end
end
