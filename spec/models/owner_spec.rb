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

require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe 'validations' do
    attributes_validations = {
      first_name:   { min_length: 3,  max_length: 50 },
      last_name:    { min_length: 3,  max_length: 50 },
      email:        { min_length: 10, max_length: 50 },
      phone_number: { min_length: 10, max_length: 20 }
    }

    attributes_validations.each do |key, length_validation|
      subject { FactoryBot.build(:owner) }

      it { should validate_presence_of(key) }
      it { should validate_length_of(key).is_at_least(length_validation[:min_length]) }
      it { should validate_length_of(key).is_at_most(length_validation[:max_length]) }
    end
  end
end
