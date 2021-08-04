class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :description
      t.boolean :completed
      t.string :author

      t.timestamps
    end
  end
end
