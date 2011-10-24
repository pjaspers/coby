require 'rake'

desc "Runs the unit tests"
task :test do
  # Build and link
  `clang -framework Foundation --std=c99 tests.m NSArray+Coby.m NSDictionary+Coby.m NSObject+Coby.m NSString+Coby.m -o test_runner`

  # Run it
  `./test_runner`
end
