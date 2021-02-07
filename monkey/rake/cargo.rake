import "#{monkey}/rake/prelude.rake"

def release_flag
	'--release'
end

def cargo cmd
        nix "cargo #{cmd}"
end

def build cmd
	cargo "build #{release_flag} #{cmd}"
end

task :default do
        build ''
end
