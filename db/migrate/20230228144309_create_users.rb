class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :external_id
      t.string :current_avatar
      t.integer :rating

      t.timestamps
    end
  end
end
