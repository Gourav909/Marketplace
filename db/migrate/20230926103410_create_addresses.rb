class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :city, foreign_key: true
      t.references :district, foreign_key: true
      t.references :property,foreign_key: true

      t.timestamps
    end
  end
end
