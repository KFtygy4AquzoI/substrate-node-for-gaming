import "#{TOP}/monkey/rake/cargo_prelude.rake"

task :test do
        cargo "test"
end

task :build do
        cargo "contract build"
end
