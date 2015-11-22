class Generate < Thor
  include Thor::Actions
  namespace :generate
  argument  :name

  desc "migration", "Generate a migration file."
  def migration
    self.class.source_root(File.dirname(__FILE__))
    say '<= Generating migration...', :blue
    template(
      'templates/migration_template.tt',
      "#{File.expand_path("../..", Dir.pwd)}" + "/#{file_name}.rb"
    )
  end

  no_commands do
    def version
      Time.now.utc.to_s.gsub(':','').gsub('-','').gsub('UTC','').gsub(' ','')
    end

    def file_name
      "db/migrations/#{version}_#{name}"
    end
  end
end
