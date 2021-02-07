def shellNix
        "#{monkey}/nix/shell.nix"
end

def nix cmd
        sh "nix-shell #{shellNix} --run \"#{cmd}\""
end
