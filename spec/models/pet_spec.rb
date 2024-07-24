# == Schema Information
#
# Table name: pets
#
#  id         :integer          not null, primary key
#  name       :string
#  kind       :string
#  breed      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :float
#

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:kind) }
    it { should validate_numericality_of(:weight)}
  end
end
