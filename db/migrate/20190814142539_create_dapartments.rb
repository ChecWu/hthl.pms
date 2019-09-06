class CreateCustomerContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name, null: false, default: ''
      t.datetime :deleted_at, null: false
      t.timestamps
    end
  end
end
