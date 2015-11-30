# Migration: 20151130025247

Sequel.migration do
  up do
    DB.create_table :tweets do
      primary_key :id
      foreign_key :user_id, :users,               null: false, on_delete: :cascade
      String      :post,       unique: false,     null: false
      DateTime    :created_at, default: Time.now, null: false
      DateTime    :updated_at,                    null: true

      constraint :post, Sequel.function(:char_length, :post) => 5..140
    end
  end

  down do
    drop_table(:tweets)
  end
end
