class AddOwnerReferenceToPets < ActiveRecord::Migration[7.1]
  def change
    add_reference :pets, :owner, index: true
  end
end
