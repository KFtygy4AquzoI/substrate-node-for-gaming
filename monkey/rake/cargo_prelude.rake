import "#{TOP}/monkey/rake/prelude.rake"

CARGO_TARGET_DIR = "#{TOP}/monkey/.target"

def make_cargo(preCmd, cmd)
        nix "CARGO_TARGET_DIR='#{CARGO_TARGET_DIR}' #{preCmd} cargo #{cmd}"
end

def cargo cmd
	make_cargo('',cmd)
end

def cargo_nightly cmd
        cargo "+nightly #{cmd}"
end

def cargo_install cmd
        cargo "install #{cmd}"
end

def cargo_contract cmd
        cargo "contract #{cmd}"
end

def cargo_contract_new cmd
        cargo_contract "new #{cmd}"
end
