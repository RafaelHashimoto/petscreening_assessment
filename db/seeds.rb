# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Clear existing data
Pet.destroy_all
Owner.destroy_all

# Create pets
Pet.create!(
  [
    { name: 'Buddy',    kind: 'Dog',  breed: 'Golden Retriever', weight: 20   },
    { name: 'Whiskers', kind: 'Cat',  breed: 'Siamese',          weight: 10   },
    { name: 'Tweety',   kind: 'Bird', breed: 'Canary',           weight: 0.08 },
    { name: 'Nemo',     kind: 'Fish', breed: 'Clownfish',        weight: 0.05 }
  ]
)

puts "Created #{Pet.count} pets"

peter = Owner.find_or_create_by(first_name: 'Peter', last_name: 'Griffin', phone_number: '55 99 1234-1234', email: 'peter@griffin.com')

puts "#{peter.name} created"

Pet.create!([
  { name: 'Brian Griffin',     kind: 'Dog', breed: 'Labrador Retriever', owner: peter, weight: 10 },
  { name: 'Brian Griffin II',  kind: 'Dog', breed: 'Labrador Retriever', owner: peter, weight: 10 },
  { name: 'Brian Griffin III', kind: 'Dog', breed: 'Labrador Retriever', owner: peter, weight: 10 }
])

puts "#{peter.first_name} #{peter.pets.count} dogs were created"

puts "Seeding BreedInfos data from DogAPI"
BreedInfos::Seed.insert_all
