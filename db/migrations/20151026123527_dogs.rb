# Migration: 20151026123527

Sequel.migration do
  up do
    DB.create_table :dogs do
      primary_key :id
      String      :name,  unique: true, size: 60,  null: false
      Integer     :paws, default: 0,               null: false
      FalseClass  :vip
      DateTime    :created_at, default: Time.now,  null: false
      DateTime    :updated_at,                     null: true
    end
    DB.create_or_replace_view :dogs_view, DB[:dogs].limit(50)
  end

  down do
    drop_table(:dogs)
  end
end
