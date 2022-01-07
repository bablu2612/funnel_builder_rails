# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_09_054613) do

  create_table "columns", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "row_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["row_id"], name: "index_columns_on_row_id"
  end

  create_table "containers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_containers_on_section_id"
  end

  create_table "element_attributes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "page_element_id"
    t.string "attribute_name"
    t.string "attribute_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_element_id"], name: "index_element_attributes_on_page_element_id"
  end

  create_table "element_styles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "page_element_id"
    t.string "style"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_element_id"], name: "index_element_styles_on_page_element_id"
  end

  create_table "funnels", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_funnels_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.string "event"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "page_columns", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "column_name"
    t.text "column_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "page_form_id"
    t.index ["page_form_id"], name: "index_page_columns_on_page_form_id"
  end

  create_table "page_elements", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "field"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "column_id"
    t.index ["column_id"], name: "index_page_elements_on_column_id"
  end

  create_table "page_forms", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_forms_on_page_id"
  end

  create_table "pages", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "funnel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "screenshot"
    t.string "background"
    t.index ["funnel_id"], name: "index_pages_on_funnel_id"
  end

  create_table "previews", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "background"
    t.index ["user_id"], name: "index_previews_on_user_id"
  end

  create_table "rows", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "container_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["container_id"], name: "index_rows_on_container_id"
  end

  create_table "sec_attributes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "section_id"
    t.bigint "container_id"
    t.bigint "row_id"
    t.bigint "column_id"
    t.string "attri"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_sec_attributes_on_column_id"
    t.index ["container_id"], name: "index_sec_attributes_on_container_id"
    t.index ["row_id"], name: "index_sec_attributes_on_row_id"
    t.index ["section_id"], name: "index_sec_attributes_on_section_id"
  end

  create_table "sections", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "preview_id"
    t.index ["page_id"], name: "index_sections_on_page_id"
    t.index ["preview_id"], name: "index_sections_on_preview_id"
  end

  create_table "styles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "section_id"
    t.bigint "container_id"
    t.bigint "row_id"
    t.bigint "column_id"
    t.string "style"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_styles_on_column_id"
    t.index ["container_id"], name: "index_styles_on_container_id"
    t.index ["row_id"], name: "index_styles_on_row_id"
    t.index ["section_id"], name: "index_styles_on_section_id"
  end

  create_table "uploads", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_uploads_on_user_id"
  end

  create_table "user_details", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "phone"
    t.string "address"
    t.string "city"
    t.string "province"
    t.integer "zipcode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "f_name"
    t.string "l_name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "password_reset_token"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "duplicate_login_token"
    t.string "image"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "columns", "rows"
  add_foreign_key "containers", "sections"
  add_foreign_key "element_attributes", "page_elements"
  add_foreign_key "element_styles", "page_elements"
  add_foreign_key "funnels", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "page_columns", "page_forms"
  add_foreign_key "page_elements", "columns"
  add_foreign_key "page_forms", "pages"
  add_foreign_key "pages", "funnels"
  add_foreign_key "previews", "users"
  add_foreign_key "rows", "containers"
  add_foreign_key "sec_attributes", "columns"
  add_foreign_key "sec_attributes", "containers"
  add_foreign_key "sec_attributes", "rows"
  add_foreign_key "sec_attributes", "sections"
  add_foreign_key "sections", "pages"
  add_foreign_key "sections", "previews"
  add_foreign_key "styles", "columns"
  add_foreign_key "styles", "containers"
  add_foreign_key "styles", "rows"
  add_foreign_key "styles", "sections"
  add_foreign_key "uploads", "users"
  add_foreign_key "user_details", "users"
end
