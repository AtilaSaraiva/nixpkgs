{ stdenv, lib, fetchFromGitHub, fetchurl, gfortran, git, toml-f }:

let
  M_CLI2 = fetchFromGitHub {
    owner = "urbanjost";
    repo = "M_CLI2";
    rev = "ea6bbffc1c2fb0885e994d37ccf0029c99b19f24";
    sha256 = "sha256-EDYTy1XbQQRt2ga9egzrIBhUwjfe89cy7+gW3Yyg86U=";
  };
in
stdenv.mkDerivation rec {
  pname = "fpm";
  version = "0.5.0";

  fpm_bootstrap = fetchurl {
    url = "https://github.com/fortran-lang/fpm/releases/download/v${version}/fpm-${version}.F90";
    sha256 = "sha256-U7uk09Cdh11RPtQwmj3v5BT6cn283rOOT9zwlOGcAlc=";
  };

  src = fetchFromGitHub {
    owner = "fortran-lang";
    repo = "fpm";
    rev = "v${version}";
    sha256 = "sha256-j6jKmlTjsgxNBMk874sb2SBZr9b408/Cx8f4TzCVgTI=";
  };

  patches = [ ./test.patch ];

  postPatch = ''
    cp -r ${M_CLI2} M_CLI2
  '';

  nativeBuildInputs = [ gfortran git toml-f ];

  preConfigure = ''
    export HOME=$PWD
  '';

  installPhase = ''
    gfortran ${fpm_bootstrap} -o fpm
    FFLAGS="-g -fbacktrace -O3"
    ./fpm install --compiler gfortran --flag "$FFLAGS" --prefix $out
  '';
    #install -Dm755 -t $out/bin/ fpm

  meta = with lib; {
    description = "Fortran Package Manager (fpm)";
    homepage = "fpm.fortran-lang.org";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ atila ];
  };
}
