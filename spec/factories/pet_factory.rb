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
FactoryBot.define do
  factory :pet do
    name   { 'Brian Griffin' }
    kind   { 'Dog' }
    breed  { 'Labrador Retriever' }
    weight { 5 }
  end
end
