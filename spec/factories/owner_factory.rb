# == Schema Information
#
# Table name: owners
#
#  id           :integer          not null, primary key
#  first_name   :string(50)
#  last_name    :string(50)
#  email        :string(50)
#  phone_number :string(20)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :owner do
    first_name    { 'Peter' }
    last_name     { 'Griffin' }
    phone_number  { '55 99 1234-1236' }
    email         { 'owner@email.com' }
  end
end
