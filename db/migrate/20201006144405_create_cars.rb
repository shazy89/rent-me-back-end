class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :vehicleType
      t.string :capacity
      t.string :baggingCapacity
      t.string :rentPrice

      t.timestamps
    end
  end
end