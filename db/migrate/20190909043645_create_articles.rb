class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :overview
      t.text :content, null: false
      t.boolean :posted, null: false, default: false
      t.string :thumbnail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
