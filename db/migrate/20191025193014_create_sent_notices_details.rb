class CreateSentNoticesDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :sent_notices_details do |t|
      t.string :sender_id
      t.integer :notices_id
      t.datetime :dtime
      t.string :grp_name

      t.timestamps
    end
  end
end
