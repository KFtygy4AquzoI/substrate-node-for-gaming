import "#{TOP}/monkey/rake/prelude.rake"

def cargo cmd
        nix "cargo #{cmd}"
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
