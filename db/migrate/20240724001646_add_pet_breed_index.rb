class AddPetBreedIndex < ActiveRecord::Migration[7.1]
  def change
    add_index :pets, :breed
  end
end
