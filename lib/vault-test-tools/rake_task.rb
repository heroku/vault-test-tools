require 'rake/testtask'

ENV['CPUPROFILE'] = './test/.test.profile'
Rake::TestTask.new do |t|
  t.verbose = true
  t.ruby_opts << '-r turn/autorun'
  t.ruby_opts << '-r perftools'
  t.ruby_opts << '-I test'
  t.test_files = FileList['test/**/*_test.rb', 'test/**/*_spec.rb']
end
