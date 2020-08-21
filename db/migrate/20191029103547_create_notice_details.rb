class CreateNoticeDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :notice_details do |t|
      t.integer :notice_id
      t.string :uploader_id
      t.string :sender_id
      t.string :sended_to

      t.timestamps
    end
  end
end
