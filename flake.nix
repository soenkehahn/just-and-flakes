{
  outputs = { self, nixpkgs }:
    let pkgs = (import nixpkgs { system = "x86_64-linux"; });
    in
    with pkgs; {
      packages.x86_64-linux.default = hello;
      devShells.x86_64-linux.default =
        mkShell { buildInputs = [ just ]; };
      checks.x86_64-linux = {
        without-hashbang = runCommand "without-hashbang"
          { buildInputs = [ just ]; }
          ''
            touch $out
            cd ${self}
            just without-hashbang
          '';
        with-hashbang = runCommand "with-hashbang"
          { buildInputs = [ just ]; }
          ''
            touch $out
            cd ${self}
            just with-hashbang
          '';
      };
    };
}
