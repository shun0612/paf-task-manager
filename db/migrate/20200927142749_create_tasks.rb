class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :subject_name
      t.datetime :deadline
      t.integer :priority
      t.text :note
      t.integer :complete_flg
      t.integer :delete_flg
      t.integer :user_id

      t.timestamps
    end
  end
end
