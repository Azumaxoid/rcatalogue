# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_15_091302) do

  create_table "sock", primary_key: "sock_id", id: { type: :string, limit: 40 }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "description", limit: 200
    t.float "price"
    t.integer "count"
    t.string "image_url_1", limit: 40
    t.string "image_url_2", limit: 40
  end

  create_table "sock_tag", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "sock_id", limit: 40
    t.integer "tag_id", limit: 3, null: false
    t.index ["sock_id"], name: "sock_id"
    t.index ["tag_id"], name: "tag_id"
  end

  create_table "tag", primary_key: "tag_id", id: { type: :integer, limit: 3 }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 20
  end

  add_foreign_key "sock_tag", "sock", primary_key: "sock_id", name: "sock_tag_ibfk_1"
  add_foreign_key "sock_tag", "tag", primary_key: "tag_id", name: "sock_tag_ibfk_2"
end
