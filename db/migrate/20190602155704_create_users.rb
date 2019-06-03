class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string            :name
      t.integer           :birthday
      t.timestamps    null: true
    end
  end
end
