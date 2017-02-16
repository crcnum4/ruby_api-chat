class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :origin
      t.integer :opponent
      t.text :message

      t.timestamps null: false
    end
  end
end
