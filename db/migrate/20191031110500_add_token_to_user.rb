class AddTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :isVerifiedByAdmin, :integer, :default => 0
  end
end
