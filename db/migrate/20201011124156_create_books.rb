class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :startDate
      t.string :endDate
      t.string :firstName
      t.string :lastName
      t.string :phoneNumber
      t.string :emailAdress
      t.string :car_id

      t.timestamps
    end
  end
end
