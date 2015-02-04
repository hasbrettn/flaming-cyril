ActiveRecord::Schema.define do
  create_table :notifications do |t|
    t.string :title
    t.string :message
    t.string :image_url
    t.string :email_address
  end
end