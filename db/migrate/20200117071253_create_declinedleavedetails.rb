class CreateDeclinedleavedetails < ActiveRecord::Migration[6.0]
  def change
    create_table :declinedleavedetails do |t|
      t.string :applicantid
      t.string :date_to
      t.string :date_from
      t.string :applied_date
      t.date :rejected_date
      t.string :reason

      t.timestamps
    end
  end
end
