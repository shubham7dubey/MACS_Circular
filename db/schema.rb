# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_03_201234) do

  create_table "declinedleavedetails", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicantid"
    t.string "date_to"
    t.string "date_from"
    t.string "applied_date"
    t.date "rejected_date"
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dynamicleavecancels", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicantid"
    t.string "date_to"
    t.string "date_from"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_data", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "cg_email"
    t.string "group_name_ref"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "group_name"
    t.string "primary_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "created_by"
    t.index ["group_name"], name: "group_name", unique: true
  end

  create_table "inchargedetails", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "inchargeid"
    t.date "dateto"
    t.date "datefrom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leaveapprovaldetails", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicantid"
    t.string "date_to", limit: 11
    t.string "date_from", limit: 11
    t.date "applied_date"
    t.string "ltype", limit: 10
    t.string "reason"
    t.string "address"
    t.string "administrationduties"
    t.string "classarrangement"
    t.integer "isapprove"
    t.date "approve_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tohalf", limit: 20
    t.string "fromhalf", limit: 20
  end

  create_table "leaveapproveddetails", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicantid"
    t.string "date_to"
    t.string "date_from"
    t.date "applied_date"
    t.string "ltype"
    t.string "reason"
    t.string "address"
    t.string "administrationduties"
    t.string "classarrangement"
    t.date "approve_date"
    t.string "tohalf"
    t.string "fromhalf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leaves", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicantid", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cl", default: 8
    t.integer "rh", default: 2
    t.integer "ch", default: 0
  end

  create_table "notice_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "notice_id"
    t.string "uploader_id"
    t.string "sender_id"
    t.string "sended_to"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notices", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "Circular_Title"
    t.string "Select_File"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["Select_File"], name: "Select_File", unique: true
  end

  create_table "restricteddates", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "holidayname"
    t.string "holidaydate"
    t.string "lastupdateddate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sent_notices_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "sender_id"
    t.integer "notices_id"
    t.datetime "dtime"
    t.string "grp_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "registration_id"
    t.string "role", default: "student"
    t.integer "isVerifiedByAdmin", default: 0
    t.string "contact_no"
    t.integer "leaveapproval", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["registration_id"], name: "registration_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
