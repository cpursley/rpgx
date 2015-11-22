require './lib/dsl/handlers.rb'

class CatHandler < RubyResty::Handlers
  model :cat

  handler(:get_cats)   { @cats.sql }
  handler(:create_cat) { @cats.insert_sql(escape_params(cat_params)) }
  handler(:get_cat)    { @cats.where(@cat_id).sql }
  handler(:update_cat) { @cats.where(@cat_id).update_sql(escape_params(cat_params)) }
  handler(:delete_cat) { @cats.where(@cat_id).delete_sql }

  private
  def self.cat_params
    %w(name karma vip)
  end
end
