with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    nodejs-16_x
    go_1_17
    libiconv
    darwin.apple_sdk.frameworks.Security
  ];

  shellHook = ''
    export PATH="$PWD/node_modules/.bin:$PATH";
  '';
}
