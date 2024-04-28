class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :cpf
      t.string :phone

      t.timestamps
    end
  end
end
