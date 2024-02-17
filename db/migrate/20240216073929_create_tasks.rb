class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.text :body
      t.boolean :completed

      t.timestamps
    end
  end
end
