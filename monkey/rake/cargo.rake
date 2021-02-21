import "#{TOP}/monkey/rake/cargo_prelude.rake"

def release_flag
  if File.exist?("#{TOP}/monkey/.use_cargo_debug")
    ''
  elsif File.exist?("#{TOP}/monkey/.use_cargo_release")
    '--release'
  else
    ''
  end
end

def cargo_skip cmd
        make_cargo('SKIP_WASM_BUILD=1', cmd)
end

task :default do
	cargo "build #{release_flag}"
end

task :build do
	cargo "build #{release_flag}"
end

task :fmt do
	cargo "fmt"
end

task :test do
	cargo_skip "test #{release_flag}"
end

task :test_all do
	cargo_skip "test #{release_flag} --all"
end

task :check do
	cargo_skip "check #{release_flag}"
end

task :check_all do
	cargo_skip "check #{release_flag} --all"
end

task :run do
	cargo "run #{release_flag} -- --dev --tmp"
end

task :run_error_head do
	cargo "run #{release_flag} -- --dev --tmp 2>&1 | awk '/(error\[)|(^error: [^f])/{ start = 1 } { if (start) { print $0 } }' | head"
end
