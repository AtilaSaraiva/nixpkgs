{ stdenv
, lib
, fetchFromGitHub
, meson
, ninja
, pkg-config
, gfortran
, test-drive
, python3
}:

stdenv.mkDerivation rec {
  pname = "toml-f";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-fIkz62ZsOLbnP/Hk1G9sIwCU+uMVHL1EU6qqN9nx82g=";
  };

  postPatch = ''
    chmod +x config/install-mod.py
    patchShebangs config/install-mod.py
  '';

  nativeBuildInputs = [
    meson
    ninja
    gfortran
    pkg-config
    test-drive
    python3
  ];

  meta = with lib; {
    description = "TOML parser implementation for data serialization and deserialization in Fortran";
    homepage = "toml-f.readthedocs.io";
    license = with licenses; [ mit asl20 ];
    platforms = platforms.unix;
    maintainers = with maintainers; [ atila ];
  };
}
