class ChangeArticleContentNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :articles, :content, true, nil
    change_column :articles, :content, :text, default: nil
  end
  def down
    change_column_null :articles, :content, false, ''
    change_column :articles, :content, :text, default: ''
  end
end
