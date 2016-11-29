FactoryGirl.define do
  factory :membership_application do
    first_name "Firstname"
    last_name "Lastname"
    company_number '1111111111'
    phone_number "MyString"
    contact_email "MyString@email.com"
    association :user
  end
end