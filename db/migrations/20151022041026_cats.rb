# Migration: 20151022041026_cats

Sequel.migration do
  up do
    DB.create_table :cats do
      primary_key :id
      String      :name,  unique: true, size: 60,  null: false
      Integer     :karma, default: 0,              null: false
      FalseClass  :vip
      DateTime    :created_at, default: Time.now,  null: false
      DateTime    :updated_at,                     null: true
    end
    DB.create_or_replace_view :cats_view, DB[:cats].limit(50)
  end

  down do
    drop_table(:cats)
  end
end
