class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :full_name
      t.float  :latitude
      t.float  :longitude
      t.string :address

      t.timestamps
    end
  end
end
