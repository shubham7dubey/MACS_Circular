class AddCreatedByToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :created_by, :string
  end
end
