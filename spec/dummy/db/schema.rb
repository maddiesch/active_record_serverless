ActiveRecord::Schema.define(version: 1) do
  create_table 'people', force: :cascade do |t|
    t.string   'username',    null: false
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end
end
