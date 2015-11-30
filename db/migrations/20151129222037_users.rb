# Migration: 20151129222037

Sequel.migration do
  up do
    DB.create_table :users do
      primary_key :id
      String      :name,       unique: true,      null: false
      String      :password,   unique: false,     null: false
      String      :email,      unique: true,      null: false
      FalseClass  :admin,      default: false
      DateTime    :created_at, default: Time.now, null: false
      DateTime    :updated_at,                    null: true

      constraint :name_length,     Sequel.function(:char_length, :name)     => 3..50
      constraint :password_length, Sequel.function(:char_length, :password) => 6..50
      constraint :email_length,    Sequel.function(:char_length, :email)    => 3..50
      constraint :email_format,    "(email ~* '^[a-z0-9._%-]+@[a-z0-9._%-]+[.][a-z]+$')"
      constraint :email_case,      "(email = lower(email))"
    end
  end

  down do
    drop_table(:users)
  end
end
