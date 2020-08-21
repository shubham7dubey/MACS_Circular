class CreateLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :leaves do |t|
      t.string :fid
      t.integer :cl, :default => 8
      t.integer :pl, :default => 8

      t.timestamps
    end
  end
end
