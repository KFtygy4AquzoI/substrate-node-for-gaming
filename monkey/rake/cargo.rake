import "#{monkey}/rake/cargo_prelude.rake"

def release_flag
        '--release'
end

def cargo_skip cmd
        nix "SKIP_WASM_BUILD=1 cargo #{cmd}"
end

task :default do
	cargo "build #{release_flag}"
end

task :build do
	cargo "build #{release_flag}"
end

task :test do
	cargo_skip "test #{release_flag} --all"
end

task :check do
	cargo_skip "check #{release_flag} --all"
end

task :run do
	cargo "run #{release_flag} -- --dev --tmp"
end
