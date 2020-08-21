class CreateDynamicleavecancels < ActiveRecord::Migration[6.0]
  def change
    create_table :dynamicleavecancels do |t|
      t.string :applicantid
      t.string :date_to
      t.string :date_from

      t.timestamps
    end
  end
end
