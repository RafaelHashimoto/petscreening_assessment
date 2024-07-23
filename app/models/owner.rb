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
class Owner < ApplicationRecord
  validates :first_name, :last_name, presence: true, length: { minimum: 3,  maximum: 50}

  validates :email,        presence: true, length: { minimum: 10, maximum: 50}
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 20}
end
