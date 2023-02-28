class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :external_id
      t.text :description
      t.integer :view
      t.integer :likes
      t.string :thumbnail_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
