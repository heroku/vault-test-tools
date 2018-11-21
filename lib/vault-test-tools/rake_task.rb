require 'rake/testtask'

Rake::TestTask.new do |t|
  t.verbose = true
  t.ruby_opts << '-I test'
  t.test_files = FileList['test/**/*_test.rb', 'test/**/*_spec.rb']
end
