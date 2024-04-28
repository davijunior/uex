class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
