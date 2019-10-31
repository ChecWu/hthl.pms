class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :company_name, null: false, default: ""

      t.timestamps
    end
  end
end
