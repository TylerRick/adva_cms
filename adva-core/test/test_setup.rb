FileUtils.touch(TEST_LOG) unless File.exists?(TEST_LOG)
ActiveRecord::Base.logger = Logger.new(TEST_LOG)
ActiveRecord::LogSubscriber.attach_to(:active_record)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.verbose = false

DatabaseCleaner.strategy = :truncation

Adva.engines.each do |engine|
  engine.paths.app.each { |path| $:.unshift(path) if File.directory?(path) }
  ActiveSupport::Dependencies.autoload_paths.unshift(*engine.paths.app)
  engine.require_patches
  engine.preload_sliced_models
  ActiveRecord::Migrator.up(engine.root.join('db/migrate'))
end

Adva.engines.each do |engine|
  factories = engine.root.join('test/test_factories.rb')
  require factories if factories.exist?
end
