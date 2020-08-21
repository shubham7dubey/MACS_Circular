class CreateLeaveapprovaldetails < ActiveRecord::Migration[6.0]
  def change
    create_table :leaveapprovaldetails do |t|
      t.string :applicantid
      t.date :date_to
      t.date :date_from
      t.date :applied_date
      t.string :ltype
      t.string :reason
      t.string :address
      t.string :administrationduties
      t.string :classarrangement
      t.integer :isapprove
      t.date :approve_date

      t.timestamps
    end
  end
end
