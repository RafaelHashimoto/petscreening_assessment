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
#
class Pet < ApplicationRecord

  validates_presence_of :name, :kind
end
