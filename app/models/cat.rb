require 'active_record'

# # DB Config
database_name = 'catdb'
database_user = 'chase'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :host     => "localhost",
  :username => "#{database_user}",
  :password => "",
  :database => "#{database_name}"
)

class Cat < ActiveRecord::Base
  connection.create_table(table_name, force: true) do |t|
    t.string      :name,  null: false
    t.integer     :karma, null: false, default: 0
    t.boolean     :vip,   null: false, default: false
    t.timestamps          null: true
  end

  @cats = Arel::Table.new(:cats)
  @@create = Arel::InsertManager.new(ActiveRecord::Base)
  @@update = Arel::UpdateManager.new(ActiveRecord::Base)
  @@delete = Arel::DeleteManager.new(ActiveRecord::Base)

  def self.literal(escaped_arg)
    Arel::Nodes::SqlLiteral.new(<<-SQL
"#{escaped_arg}"
SQL
)
  end

  @escaped_id = literal("cats.id=$escaped_id")

  def self.get_cats
    self.all
  end

  def self.create_cat
    # create mapper for this stuff. But how to deal with literal? Auto-convert if integer or force for all
    #params = %w(name karma vip)
    @@create.insert([
              [@cats[:name], "$name"],
              [@cats[:karma], literal("$karma")],
              [@cats[:vip], "$vip"]
            ])
    @@create
  end

  def self.get_cat
    self.where(@escaped_id)
  end

  def self.update_cat
    @@update.table(@cats)
            .where(literal(@escaped_id))
            .set([
              [@cats[:name], "$name"],
              [@cats[:karma], literal("$karma")],
              [@cats[:vip], "$vip"]
            ])
    @@update
  end

  def self.destroy_cat
    @@delete.from(@cats).where(@escaped_id)
    @@delete
  end
end

Cat.create!(name: "Scratch", karma: 89, vip: true)
Cat.create!(name: "Meow", karma: 105, vip: false)
