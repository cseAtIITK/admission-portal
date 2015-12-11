class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.text    :name, index: true
      t.text    :username, index: true
      t.text    :email, index: true
      t.text    :password_digest
      t.integer :role
      t.timestamps null: false
    end
  end
end
