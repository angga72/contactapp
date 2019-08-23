class CreateNoContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :no_contacts do |t|
      t.references :contact, null: false, foreign_key: true
      t.integer :no_type
      t.string :number

      t.timestamps
    end
  end
end
