class AddArticleDigestToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :id_digest, :string
  end
end
