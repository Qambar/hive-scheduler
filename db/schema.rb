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

ActiveRecord::Schema.define(version: 20170315110114) do

  create_table "artifacts", force: :cascade do |t|
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  add_index "artifacts", ["job_id"], name: "index_artifacts_on_job_id"

  create_table "assets", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "name",               limit: 255
    t.string   "file",               limit: 255
    t.string   "version",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  add_index "assets", ["project_id"], name: "index_assets_on_project_id"

  create_table "batch_assets", force: :cascade do |t|
    t.integer  "batch_id"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batch_assets", ["asset_id"], name: "index_batch_assets_on_asset_id"
  add_index "batch_assets", ["batch_id"], name: "index_batch_assets_on_batch_id"

  create_table "batches", force: :cascade do |t|
    t.string   "name",                        limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id",                              null: false
    t.string   "version",                     limit: 255, null: false
    t.string   "build_file_name",             limit: 255
    t.string   "build_content_type",          limit: 255
    t.integer  "build_file_size"
    t.datetime "build_updated_at"
    t.binary   "target_information"
    t.integer  "number_of_automatic_retries"
    t.binary   "execution_variables"
  end

  add_index "batches", ["project_id"], name: "index_batches_on_project_id"

  create_table "curated_queues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.binary   "queues"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "fields", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "field_type",    limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_value", limit: 255
  end

  add_index "fields", ["owner_id", "owner_type"], name: "index_fields_on_owner_id_and_owner_type"

  create_table "hive_queues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hive_queues_workers", id: false, force: :cascade do |t|
    t.integer "worker_id",     null: false
    t.integer "hive_queue_id", null: false
  end

  add_index "hive_queues_workers", ["hive_queue_id", "worker_id"], name: "index_hive_queues_workers_on_hive_queue_id_and_worker_id", unique: true
  add_index "hive_queues_workers", ["worker_id"], name: "index_hive_queues_workers_on_worker_id"

  create_table "job_groups", force: :cascade do |t|
    t.integer  "batch_id"
    t.string   "name",                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "execution_variables"
    t.integer  "hive_queue_id"
  end

  add_index "job_groups", ["batch_id"], name: "index_job_groups_on_batch_id"
  add_index "job_groups", ["hive_queue_id"], name: "index_job_groups_on_hive_queue_id"

  create_table "jobs", force: :cascade do |t|
    t.string   "job_name",            limit: 255,             null: false
    t.string   "state",               limit: 255,             null: false
    t.integer  "queued_count"
    t.integer  "running_count"
    t.integer  "passed_count"
    t.integer  "failed_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "errored_count"
    t.integer  "retry_count",                     default: 0, null: false
    t.integer  "device_id"
    t.integer  "job_group_id"
    t.integer  "original_job_id"
    t.binary   "execution_variables"
    t.datetime "reserved_at"
    t.binary   "reservation_details"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "result",              limit: 255
    t.integer  "exit_value"
    t.text     "message"
    t.datetime "script_start_time"
    t.datetime "script_end_time"
  end

  add_index "jobs", ["device_id"], name: "index_jobs_on_device_id"
  add_index "jobs", ["job_group_id"], name: "index_jobs_on_job_group_id"
  add_index "jobs", ["original_job_id"], name: "index_jobs_on_original_job_id"
  add_index "jobs", ["state", "job_group_id"], name: "index_jobs_on_state_and_job_group_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name",                limit: 255,               null: false
    t.string   "repository",          limit: 255,               null: false
    t.string   "execution_directory", limit: 255, default: ".", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "script_id",                                     null: false
    t.string   "builder_name",        limit: 255
    t.binary   "builder_options"
    t.datetime "deleted_at"
    t.binary   "execution_variables"
    t.string   "branch"
  end

  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at"
  add_index "projects", ["script_id"], name: "index_projects_on_script_id"

  create_table "scripts", force: :cascade do |t|
    t.string   "name",          limit: 255,                 null: false
    t.text     "template",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
    t.boolean  "install_build",             default: false
  end

  create_table "targets", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "icon",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "requires_build",             default: false
  end

  create_table "test_cases", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "urn",        limit: 255
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_cases", ["project_id"], name: "index_test_cases_on_project_id"

  create_table "test_results", force: :cascade do |t|
    t.string   "status",       limit: 255
    t.text     "message"
    t.integer  "test_case_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_results", ["job_id"], name: "index_test_results_on_job_id"
  add_index "test_results", ["test_case_id"], name: "index_test_results_on_test_case_id"

  create_table "users", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "email",    limit: 255
    t.string "provider", limit: 255
    t.string "uid",      limit: 255
  end

  create_table "workers", force: :cascade do |t|
    t.integer  "hive_id"
    t.integer  "pid"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["hive_id", "pid", "device_id"], name: "index_hive_id_pid_on_workers"

end
