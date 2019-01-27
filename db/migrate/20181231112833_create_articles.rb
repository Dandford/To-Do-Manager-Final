class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :task	
      t.text :deadline

      t.timestamps
    end
  end

end
