{ stdenv
, lib
, fetchFromGitHub
, cmake
, ninja
, pcaudiolib
}:

stdenv.mkDerivation rec {
  pname = "googerteller";
  version = "unstable-2022-08-29";

  src = fetchFromGitHub {
    owner = "berthubert";
    repo = pname;
    rev = "806cd6056902935fe61f3fa163d5cfe9ee4a9543";
    sha256 = "sha256-Z8+v1gpepaQKU6LDgKPuHDZ05+6p01LFqRC20G/fPgg=";
  };

  nativeBuildInputs = [ cmake ninja pcaudiolib ];

  installPhase = ''
    runHook preInstall

    install -Dm755 teller $out/bin/teller

    runHook postInstall
  '';

  meta = with lib; {
    description = "Audible feedback on just how much your browsing feeds into google";
    homepage = "https://github.com/berthubert/googerteller";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ atila ];
  };
}
