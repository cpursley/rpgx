require './lib/dsl/handlers.rb'

class UserHandler < RubyResty::Handlers
  model :user

  handler(:get_users)   { @users.sql }
  handler(:create_user) { @users.insert_sql(user_params) }
  handler(:get_user)    { @users.where(@user_id).sql }
  handler(:update_user) { @users.where(@user_id).update_sql(user_params) }
  handler(:delete_user) { @users.where(@user_id).delete_sql }

  private
  def self.user_params
    escape_params %w(username)
  end
end
