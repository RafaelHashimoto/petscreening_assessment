class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :first_name,   limit: 50
      t.string :last_name,    limit: 50
      t.string :email,        limit: 50
      t.string :phone_number, limit: 20
      t.timestamps
    end
  end
end
