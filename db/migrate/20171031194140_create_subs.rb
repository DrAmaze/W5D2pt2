class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :subs, :title
  end
end