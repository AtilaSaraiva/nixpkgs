{ stdenv
, lib
, fetchFromGitLab
, gradle
, jdk11
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "tapenade";
  version = "3.16-v2";

  src = fetchFromGitLab {
    owner = pname;
    repo = pname;
    rev = version;
    sha256 = "";
  };

  nativeBuildInputs = [ jdk11 gradle ];

  buildPhase = ''
    export GRADLE_USER_HOME=$(mktemp -d);
    ./gradlew
  '';
}
