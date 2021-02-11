{ sources ? import ./sources.nix }:

let

  preset = import sources.nixpkgs { config.android_sdk.accept_license = true;};
  android = preset.callPackage ./android.nix { };

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


in
with nixpkgs; pkgs.mkShell {
  buildInputs = [

    git

    clang
    cmake
    pkg-config
    rust-nightly

    preset.flutter
    preset.jdk
    preset.niv
    android.platform-tools


  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";
  PROTOC = "${protobuf}/bin/protoc";
  ROCKSDB_LIB_DIR = "${rocksdb}/lib";

  ANDROID_HOME = "${android.androidsdk}/libexec/android-sdk";
  JAVA_HOME = preset.jdk;
  ANDROID_AVD_HOME = (toString ./.) + "/.android/avd";

}

