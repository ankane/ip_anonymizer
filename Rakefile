require "bundler/gem_tasks"
require "rake/testtask"
require "benchmark/ips"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

task :benchmark do
  require "ip_anonymizer"
  Benchmark.ips do |x|
    x.report("mask_ip") { IpAnonymizer.mask_ip("8.8.4.4") }
    x.report("hash_ip") { IpAnonymizer.hash_ip("8.8.4.4", key: "secret") }
  end
end
