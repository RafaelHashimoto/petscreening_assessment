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
#  owner_id   :integer
#
class Pet < ApplicationRecord
  # associations
  belongs_to :owner, optional: true
  belongs_to :breed_info, primary_key: 'name', foreign_key: 'breed', class_name: 'BreedInfo', optional: true

  # validations
  validates_presence_of :name, :kind
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than: 10000 }

end
