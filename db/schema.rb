# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160617121732) do

  create_table "asdf", id: false, force: :cascade do |t|
    t.text "a"
  end

  create_table "comentarios", force: :cascade do |t|
    t.integer  "prototipo_id", null: false
    t.string   "nome",         null: false
    t.text     "mensagem",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "config_prototipos", force: :cascade do |t|
    t.string   "type",       null: false
    t.string   "label",      null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "formularios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pessoas", force: :cascade do |t|
    t.string   "nome",       null: false
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prototipos", force: :cascade do |t|
    t.text     "nome",          null: false
    t.string   "tarefas",       null: false
    t.string   "categoria",     null: false
    t.text     "mockup"
    t.text     "link",          null: false
    t.string   "etapa",         null: false
    t.string   "status",        null: false
    t.string   "analista",      null: false
    t.string   "desenvolvedor"
    t.string   "relevancia"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "prototype_sc_controllers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prototype_scs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
