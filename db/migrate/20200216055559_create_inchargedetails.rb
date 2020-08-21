class CreateInchargedetails < ActiveRecord::Migration[6.0]
  def change
    create_table :inchargedetails do |t|
      t.string :inchargeid
      t.date :dateto
      t.date :datefrom

      t.timestamps
    end
  end
end
