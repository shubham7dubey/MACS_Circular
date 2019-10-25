class CreateGroupData < ActiveRecord::Migration[6.0]
  def change
    create_table :group_data do |t|
      t.string :cg_email
      t.string :group_name_ref

      t.timestamps
    end
  end
end
