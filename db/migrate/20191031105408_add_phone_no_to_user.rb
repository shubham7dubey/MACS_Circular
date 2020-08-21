class AddPhoneNoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :contact_no, :string
  end
end
