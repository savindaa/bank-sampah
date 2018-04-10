class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.string :author
      t.string :source

      t.timestamps
    end
    add_index :articles, :title
    add_index :articles, :author
  end
end
