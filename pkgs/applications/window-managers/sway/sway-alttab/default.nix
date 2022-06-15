{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "sway-alttab";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "x1b6e6";
    repo = pname;
    rev = "v${version}";
    sha256 = "";
  };
}
