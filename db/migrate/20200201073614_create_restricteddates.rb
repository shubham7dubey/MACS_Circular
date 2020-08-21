class CreateRestricteddates < ActiveRecord::Migration[6.0]
  def change
    create_table :restricteddates do |t|
      t.string :holidayname
      t.string :holidaydate
      t.string :lastupdateddate

      t.timestamps
    end
  end
end
