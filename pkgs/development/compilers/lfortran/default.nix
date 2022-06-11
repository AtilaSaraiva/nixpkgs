{ stdenv, lib, fetchFromGitLab, cmake, zlib }:

stdenv.mkDerivation rec {
  pname = "lfortran";
  version = "0.15.0";

  src = fetchFromGitLab {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-tdgAJgK+2DKkwaWlwTt+KOBkdst9Q2JRYmzZmsE+tB8=";
  };

  nativeBuildInputs = [ cmake zlib ];
}
