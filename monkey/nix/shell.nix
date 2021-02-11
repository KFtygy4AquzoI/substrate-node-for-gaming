let

  mozillaOverlay =
    import (builtins.fetchGit {
      url = "https://github.com/mozilla/nixpkgs-mozilla.git";
      rev = "18cd4300e9bf61c7b8b372f07af827f6ddc835bb";
    });

  nixpkgs = import <nixpkgs> { overlays = [ mozillaOverlay ]; };

  rust-nightly = with nixpkgs; ((rustChannelOf { date = "2020-10-23"; channel = "nightly"; }).rust.override {
    targets = [ "wasm32-unknown-unknown" ];
    extensions = ["rust-src"];
  });

  flutterPkgs =
    import (builtins.fetchGit {
      url = "https://github.com/babariviere/nixpkgs.git";
      rev = "fc592a52cacfbf5f22e6479a22263983f5346ea6";
  });

  dartPkgs =
    import (builtins.fetchGit {
      url = "https://github.com/GRBurst/nixpkgs.git";
      rev = "47639c945ea305be65abce5649f61529e5b6f011";
  });

in
with nixpkgs; pkgs.mkShell {
  buildInputs = [

    git

    clang
    cmake
    pkg-config
    rust-nightly

    flutterPkgs.flutter
    dartPkgs.dart
    android-studio

  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  PROTOC = "${protobuf}/bin/protoc";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";
}

