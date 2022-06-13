{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, gfortran
}:

stdenv.mkDerivation rec {
  pname = "test-drive";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "fortran-lang";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-ObAnHFP1Hp0knf/jtGHynVF0CCqK47eqetePx4NLmlM=";
  };

  nativeBuildInputs = [ meson ninja gfortran ];

  meta = with lib; {
    description = "The simple testing framework";
    homepage = "https://github.com/fortran-lang/test-drive";
    license = with licenses; [ mit asl20 ];
    platforms = platforms.unix;
    maintainers = with maintainers; [ atila ];
  };
}
