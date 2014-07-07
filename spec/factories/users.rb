# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "mail2gok@gmail.com"
    password "password123"
    password_confirmation "password123"
    full_name "Gokulamurthy P"
  end
end
