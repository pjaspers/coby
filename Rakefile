require 'rake'

desc "Runs the unit tests"
task :test do
  # This is probably the most ineffective way ever do build
  # this, but it's fast and it works. #winning.
  Dir.glob("*.m").each do |f|
    # Building
    `clang -x objective-c -c #{f} -o build/#{File.basename(f, ".m")}.o`
  end

  # Linking
  `clang -arch x86_64 -framework Cocoa -o test_runner #{Dir.glob("build/*.o").join(" ")}`

  # Run it
  `./test_runner`
end
