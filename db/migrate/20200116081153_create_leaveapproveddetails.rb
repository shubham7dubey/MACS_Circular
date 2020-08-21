class CreateLeaveapproveddetails < ActiveRecord::Migration[6.0]
  def change
    create_table :leaveapproveddetails do |t|
      t.string :applicantid
      t.string :date_to
      t.string :date_from
      t.date :applied_date
      t.string :ltype
      t.string :reason
      t.string :address
      t.string :administrationduties
      t.string :classarrangement
      t.date :approve_date
      t.string :tohalf
      t.string :fromhalf

      t.timestamps
    end
  end
end
