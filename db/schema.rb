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

ActiveRecord::Schema.define(version: 20131114142935) do

  create_table "admin_users", force: true do |t|
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
    t.string   "username",           default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",    default: 0
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["username"], name: "index_admin_users_on_username", unique: true, using: :btree

  create_table "article_images", force: true do |t|
    t.string   "image"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_file_size"
    t.string   "image_content_type"
  end

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preview_image"
    t.boolean  "case_study"
    t.text     "preview"
    t.integer  "preview_image_file_size"
    t.string   "preview_image_content_type"
    t.string   "author"
    t.datetime "published_at"
  end

  create_table "artworks", force: true do |t|
    t.integer  "customer_number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "upload"
    t.integer  "upload_file_size"
    t.string   "upload_content_type"
  end

  create_table "carousel_items", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_file_size"
    t.string   "image_content_type"
  end

  create_table "carousel_tags", force: true do |t|
    t.integer  "carousel_item_id"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "options_category"
    t.boolean  "build_category",         default: false
    t.string   "thumbnail"
    t.integer  "thumbnail_file_size"
    t.string   "thumbnail_content_type"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "category_series", force: true do |t|
    t.integer  "category_id"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_blacklist", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "customer_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "cov_customers", force: true do |t|
    t.integer  "customer_number"
    t.string   "company_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_fax"
    t.string   "default_salesperson"
    t.date     "date_added"
    t.date     "last_activity_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cov_customers", ["customer_number"], name: "index_cov_customers_on_customer_number", using: :btree

  create_table "cov_order_lines", force: true do |t|
    t.integer  "order_number"
    t.integer  "sequence_id"
    t.integer  "quantity"
    t.string   "product_code"
    t.string   "description"
    t.decimal  "setup",           precision: 16, scale: 2
    t.decimal  "unit_price",      precision: 16, scale: 2
    t.decimal  "line_unit_price", precision: 16, scale: 2
    t.decimal  "sales_tax",       precision: 16, scale: 2
    t.decimal  "amount",          precision: 16, scale: 2
    t.string   "currency"
    t.decimal  "currency_mult",   precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cov_orders", force: true do |t|
    t.integer  "order_number"
    t.date     "order_date"
    t.string   "order_description"
    t.string   "po_number"
    t.date     "order_due_date"
    t.string   "default_ship_method"
    t.integer  "quote_number"
    t.integer  "quote_version"
    t.integer  "customer_number"
    t.string   "customer_name"
    t.string   "cust_address_1"
    t.string   "cust_address_2"
    t.string   "cust_city"
    t.string   "cust_state"
    t.string   "cust_zipcode"
    t.string   "cust_country"
    t.string   "product_code"
    t.string   "product_description"
    t.integer  "order_quantity"
    t.decimal  "order_amount",          precision: 16, scale: 2
    t.string   "csr_name"
    t.string   "csr_email"
    t.string   "csr_phone"
    t.string   "csr_extension"
    t.string   "distributor_name"
    t.string   "dist_address_1"
    t.string   "dist_address_2"
    t.string   "dist_city"
    t.string   "dist_state"
    t.string   "dist_zipcode"
    t.string   "dist_country"
    t.string   "dist_contact_fname"
    t.string   "dist_contact_lname"
    t.string   "dist_contact_phone"
    t.string   "dist_contact_email"
    t.string   "comment_1"
    t.string   "comment_2"
    t.string   "comment_3"
    t.string   "comment_4"
    t.string   "order_status_desc"
    t.date     "order_status_date"
    t.boolean  "is_closed"
    t.date     "closed_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "subtotal_setup",        precision: 16, scale: 2
    t.decimal  "subtotal",              precision: 16, scale: 2
    t.decimal  "subtotal_setup_can",    precision: 16, scale: 2
    t.decimal  "subtotal_can",          precision: 16, scale: 2
    t.decimal  "grand_total_setup",     precision: 16, scale: 2
    t.decimal  "grand_total",           precision: 16, scale: 2
    t.decimal  "grand_total_setup_can", precision: 16, scale: 2
    t.decimal  "grand_total_can",       precision: 16, scale: 2
    t.string   "terms"
    t.string   "paper_proof_date"
    t.string   "actual_proof_date"
    t.integer  "order_status_code"
    t.string   "order_status_friendly"
    t.decimal  "cad_rate",              precision: 10, scale: 2
    t.datetime "firm_date"
    t.boolean  "has_date"
    t.string   "billing_status"
  end

  add_index "cov_orders", ["customer_number"], name: "index_cov_orders_on_customer_number", using: :btree
  add_index "cov_orders", ["order_number"], name: "index_cov_orders_on_order_number", using: :btree

  create_table "cov_ship_to_addresses", force: true do |t|
    t.integer  "order_number"
    t.integer  "ship_to_sequence"
    t.string   "ship_to_key"
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "contact_f_name"
    t.string   "contact_l_name"
    t.string   "phone"
    t.string   "email"
    t.string   "shipping_method"
    t.integer  "quantity"
    t.date     "scheduled_ship_date"
    t.string   "notes"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "freight_acct"
  end

  add_index "cov_ship_to_addresses", ["ship_to_key"], name: "index_cov_ship_to_addresses_on_ship_to_key", using: :btree

  create_table "cov_shipments", force: true do |t|
    t.integer  "order_number"
    t.integer  "ship_to_sequence"
    t.string   "ship_to_key"
    t.string   "shipment_key"
    t.string   "carrier_code"
    t.string   "service_type"
    t.string   "carrier_shipment_id"
    t.text     "package_id"
    t.date     "shipment_date"
    t.integer  "packages"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cov_shipments", ["order_number"], name: "index_cov_shipments_on_order_number", using: :btree
  add_index "cov_shipments", ["ship_to_key"], name: "index_cov_shipments_on_ship_to_key", using: :btree

  create_table "cov_statuses", force: true do |t|
    t.integer  "code"
    t.string   "description"
    t.string   "translation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "covers", force: true do |t|
    t.string   "cover_series"
    t.integer  "material_number"
    t.string   "name"
    t.string   "material_type"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reverse_text",         default: false
    t.boolean  "hide_material_number", default: false
    t.string   "swatch"
    t.string   "texture"
  end

  create_table "creative_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",           default: "Greenhorn"
    t.boolean  "in_queue"
    t.string   "phone_number"
  end

  add_index "creative_users", ["email"], name: "index_creative_users_on_email", unique: true, using: :btree
  add_index "creative_users", ["remember_token"], name: "index_creative_users_on_remember_token", using: :btree

  create_table "customer_contacts", force: true do |t|
    t.integer  "distributor_id"
    t.integer  "customer_number"
    t.integer  "order_number"
    t.string   "email_template"
    t.string   "reason"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "body"
    t.boolean  "is_urgent"
    t.integer  "invoice_id"
  end

  add_index "customer_contacts", ["order_number", "email_template"], name: "index_customer_contacts_on_order_number_and_email_template", using: :btree
  add_index "customer_contacts", ["slug"], name: "index_customer_contacts_on_slug", using: :btree
  add_index "customer_contacts", ["status"], name: "index_customer_contacts_on_status", using: :btree

  create_table "customer_responses", force: true do |t|
    t.integer  "contact_id"
    t.string   "response_type"
    t.string   "name"
    t.string   "email"
    t.text     "comment"
    t.datetime "firm_date"
    t.datetime "landed_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "timedout"
    t.boolean  "has_date"
  end

  add_index "customer_responses", ["contact_id"], name: "index_customer_responses_on_contact_id", using: :btree

  create_table "distributors", force: true do |t|
    t.integer  "customer_number"
    t.integer  "asi_number"
    t.integer  "ppi_number"
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "invoicee_name"
    t.string   "invoicee_email"
    t.boolean  "invoicee_chosen"
    t.boolean  "invoice_emails_permitted", default: true
    t.date     "last_order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "distributors", ["customer_number"], name: "index_distributors_on_customer_number", using: :btree

  create_table "documents", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "resource_type"
    t.string   "attachment"
    t.integer  "attachment_file_size"
    t.string   "attachment_content_type"
  end

  create_table "emblems", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foils", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "swatch"
    t.string   "foil_type"
    t.boolean  "for_poly"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "homepage_ads", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "link"
    t.integer  "position"
    t.boolean  "live"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "preview_image"
    t.string   "main_image"
    t.integer  "main_image_file_size"
    t.string   "main_image_content_type"
    t.integer  "preview_image_file_size"
    t.string   "preview_image_content_type"
  end

  create_table "invoice_lines", force: true do |t|
    t.integer  "order_number"
    t.integer  "invoice_number"
    t.integer  "line_number"
    t.string   "product_code"
    t.integer  "quantity"
    t.string   "description"
    t.decimal  "unit_price",     precision: 16, scale: 2
    t.decimal  "extended_price", precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.integer  "order_number"
    t.integer  "invoice_number"
    t.integer  "customer_number"
    t.string   "po_number"
    t.string   "invoice_date"
    t.decimal  "sales_tax_percent",          precision: 16, scale: 2
    t.decimal  "sales_amount",               precision: 16, scale: 2
    t.decimal  "handling_charge",            precision: 16, scale: 2
    t.decimal  "freight_charge",             precision: 16, scale: 2
    t.decimal  "sales_tax_amount",           precision: 16, scale: 2
    t.decimal  "invoice_amount",             precision: 16, scale: 2
    t.string   "invoice_due_date"
    t.string   "terms_code"
    t.string   "ship_via_description"
    t.string   "bill_name"
    t.string   "bill_address_1"
    t.string   "bill_address_2"
    t.string   "bill_city"
    t.string   "bill_state"
    t.string   "bill_zip"
    t.string   "bill_country"
    t.string   "ship_name"
    t.string   "ship_address_1"
    t.string   "ship_address_2"
    t.string   "ship_city"
    t.string   "ship_state"
    t.string   "ship_zip"
    t.string   "ship_country"
    t.string   "currency_code"
    t.decimal  "currency_multiplier",        precision: 16, scale: 2
    t.decimal  "invoice_amount_in_currency", precision: 16, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "status",                                              default: "new"
  end

  create_table "materials", force: true do |t|
    t.integer  "product_id"
    t.string   "material"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "old_distributors", force: true do |t|
    t.integer  "customer_number"
    t.string   "generated_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.integer  "asi_number"
    t.integer  "ppi_number"
    t.string   "company_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.text     "business_description"
    t.date     "business_est_date"
    t.string   "supplier_1"
    t.string   "supplier_2"
    t.boolean  "use_covalent_info"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "last_order_date"
    t.boolean  "email_opt_in"
    t.string   "migration_status"
  end

  add_index "old_distributors", ["customer_number"], name: "index_old_distributors_on_customer_number", using: :btree

  create_table "option_group_documents", force: true do |t|
    t.integer "document_id"
    t.integer "option_group_id"
  end

  create_table "option_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "layout"
    t.text     "description"
    t.text     "side_description"
    t.string   "masthead"
    t.integer  "product_document_id"
  end

  create_table "options", force: true do |t|
    t.integer  "option_group_id"
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sizes"
    t.text     "prices"
    t.string   "image"
    t.string   "thumbnail"
    t.string   "hires"
    t.text     "prices_cad"
  end

  create_table "payment_transactions", force: true do |t|
    t.integer  "payment_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "invoice_id"
    t.string   "ip_address"
    t.string   "name"
    t.integer  "last_four"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_variant_data", force: true do |t|
    t.integer  "price_variant_id"
    t.integer  "quantity"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_variants", force: true do |t|
    t.integer  "series_id"
    t.string   "label"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_versions", force: true do |t|
    t.string   "status"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cad_rate",   precision: 6, scale: 2, default: 1.0
  end

  create_table "prices", force: true do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version_id"
    t.string   "currency"
  end

  create_table "product_documents", force: true do |t|
    t.integer  "product_id"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", force: true do |t|
    t.integer  "product_id"
    t.string   "image"
    t.integer  "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_option_categories", force: true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_options", force: true do |t|
    t.integer  "option_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_suggestions", force: true do |t|
    t.integer  "suggested_for_id", null: false
    t.integer  "suggestion_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "size"
    t.integer  "sheets"
    t.text     "description"
    t.integer  "ship_time"
    t.boolean  "is_new"
    t.boolean  "is_refillable"
    t.boolean  "is_wrapped_spine"
    t.boolean  "is_full_color"
    t.boolean  "is_recycled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price_mode"
    t.integer  "main_image_id"
  end

  create_table "promos", force: true do |t|
    t.string   "page"
    t.string   "layout"
    t.integer  "position"
    t.string   "image"
    t.string   "link"
    t.string   "headline"
    t.text     "copy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tab_label"
  end

  create_table "quote_requests", force: true do |t|
    t.integer  "customer_number"
    t.string   "company_name"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cnumber"
    t.boolean  "needs_dist"
    t.integer  "quantity"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "postal_code"
    t.integer  "series_id"
    t.integer  "product_id"
  end

  create_table "registrations", force: true do |t|
    t.string   "company_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_phone"
    t.string   "user_email"
    t.boolean  "email_opt_in"
    t.integer  "asi_number"
    t.integer  "ppi_number"
    t.string   "asi_found"
    t.string   "email_found"
    t.boolean  "covalent_match"
    t.string   "status"
    t.integer  "user_id"
    t.integer  "assigned_customer_number"
    t.string   "assignment_disposition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
  end

  create_table "sale_items", force: true do |t|
    t.string   "name"
    t.string   "product_code"
    t.string   "category"
    t.text     "description"
    t.text     "price"
    t.text     "price_text"
    t.string   "image"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sample_requests", force: true do |t|
    t.string   "company_name"
    t.string   "contact_name"
    t.string   "email"
    t.integer  "series_id"
    t.integer  "product_id"
    t.string   "ship_to_company_name"
    t.string   "ship_to_contact_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "state"
    t.string   "postal_code"
    t.string   "shipping_number"
    t.text     "comment"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.text     "keywords"
    t.text     "product_code"
    t.text     "series"
    t.text     "sizes"
    t.text     "ship_times"
    t.text     "materials"
    t.text     "price_ranges"
    t.text     "features"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", force: true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "position"
    t.string   "layout"
    t.text     "description"
    t.text     "side_description"
    t.string   "masthead"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price_code",            default: "C"
    t.boolean  "more_covers_available", default: false
    t.text     "price_note"
    t.string   "slug"
    t.string   "headline"
    t.integer  "image_product_id"
    t.boolean  "hide_foils",            default: false
    t.boolean  "is_featured"
  end

  add_index "series", ["slug"], name: "index_series_on_slug", using: :btree

  create_table "series_covers", force: true do |t|
    t.integer  "series_id"
    t.integer  "cover_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "series_covers", ["cover_id"], name: "index_series_covers_on_cover_id", using: :btree
  add_index "series_covers", ["series_id"], name: "index_series_covers_on_series_id", using: :btree

  create_table "series_documents", force: true do |t|
    t.integer "document_id"
    t.integer "series_id"
  end

  create_table "series_emblems", force: true do |t|
    t.integer  "series_id"
    t.integer  "emblem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series_products", force: true do |t|
    t.integer  "series_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "phone"
    t.string   "extention"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.string   "bio_image"
    t.integer  "bio_image_file_size"
    t.string   "bio_image_content_type"
    t.boolean  "team_page"
    t.boolean  "social_icons"
    t.string   "department"
    t.string   "likes"
    t.string   "dislikes"
    t.integer  "rank"
  end

  create_table "users", force: true do |t|
    t.integer  "distributor_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "is_primary"
    t.boolean  "email_opt_in"
    t.boolean  "user_confirmed"
    t.datetime "last_login_at"
    t.integer  "old_distributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0
    t.datetime "locked_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "video_comments", force: true do |t|
    t.integer  "video_id"
    t.integer  "distributor_id"
    t.string   "status"
    t.text     "comment"
    t.datetime "moderated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.text     "embed_code"
    t.boolean  "distributor_only"
    t.string   "title"
    t.string   "slug"
    t.string   "length"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail"
    t.integer  "thumbnail_file_size"
    t.string   "thumbnail_content_type"
  end

  create_table "virtual_book_options", force: true do |t|
    t.integer  "virtual_book_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "virtual_books", force: true do |t|
    t.string   "size"
    t.string   "material_number"
    t.integer  "filler_quantity"
    t.string   "binding_color"
    t.string   "art_size"
    t.string   "art_position"
    t.string   "foil_color"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "virtual_requests", force: true do |t|
    t.integer  "distributor_id"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.string   "quantity"
    t.string   "budget"
    t.string   "target_audience"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_number"
    t.string   "art"
    t.integer  "art_file_size"
    t.string   "art_content_type"
    t.string   "company"
    t.integer  "creative_user_id"
    t.datetime "due_date"
    t.string   "art_website"
    t.boolean  "priority"
    t.string   "purchase_order"
    t.integer  "user_id"
    t.integer  "artist_id"
    t.boolean  "revision_requested"
    t.boolean  "completed",          default: false
  end

  add_index "virtual_requests", ["artist_id"], name: "index_virtual_requests_on_artist_id", using: :btree

  create_table "virtuals", force: true do |t|
    t.string   "document"
    t.integer  "document_file_size"
    t.string   "document_content_type"
    t.string   "recipients"
    t.integer  "virtual_request_id"
    t.integer  "creative_user_id"
    t.integer  "version",               default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "user_comments"
    t.text     "artist_comments"
    t.datetime "sent"
    t.string   "quote_number"
  end

  add_index "virtuals", ["creative_user_id"], name: "index_virtuals_on_creative_user_id", using: :btree
  add_index "virtuals", ["virtual_request_id"], name: "index_virtuals_on_virtual_request_id", using: :btree

end
