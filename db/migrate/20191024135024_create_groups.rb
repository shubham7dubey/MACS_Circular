class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :group_name, :primary_key

      t.timestamps
    end
  end
end
