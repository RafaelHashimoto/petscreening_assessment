class CreateBreedInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_infos do |t|
      t.string  :name
      t.string  :description
      t.integer :max_life_expectancy
      t.integer :male_max_weight
      t.integer :male_min_weight
      t.integer :female_max_weight
      t.integer :female_min_weight
      t.boolean :hypoallergenic
      t.timestamps
    end

    add_index :breed_infos, :name, unique: true
  end
end
