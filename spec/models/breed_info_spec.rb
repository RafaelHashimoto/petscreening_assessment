# == Schema Information
#
# Table name: breed_infos
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :string
#  max_life_expectancy :integer
#  male_max_weight     :integer
#  male_min_weight     :integer
#  female_max_weight   :integer
#  female_min_weight   :integer
#  hypoallergenic      :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe BreedInfo, type: :model do
  describe 'associations' do
    it { should have_many(:pets) }
  end
end
