{stdenv
, lib
, fetchFromGitHub
, cmake
, ninja
, nasm
, gtk3
, libsecret
, libgcrypt
, freeglut
, libpulseaudio
, SDL2
, curl
, pugixml
, imgui
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "cemu-emulator";
  version = "unstable-2022-08-30";

  #src = fetchFromGitHub {
    #owner = "cemu-project";
    #repo = "Cemu";
    #rev = "v${version}";
    #sha256 = "sha256-X6Rju/JENTqtqapGo/a1nAnobdJfyhkxTOn17d6NXJI=";
  #};
  src = fetchFromGitHub {
    owner = "cemu-project";
    repo = "Cemu";
    rev = "527ee3aea5fc2bc80d51cee5812673e8baff70ff";
    sha256 = "sha256-Rvsa+3sHEMOfY7rkXAmqsTbM8QixxoGry/NkoqlEHro=";
  };

  cmakeFlags = [
    "-DCMAKE_MAKE_PROGRAM=${ninja}/bin/ninja"
    "-DCMAKE_BUILD_TYPE=release"
    "-DENABLE_VCPKG=OFF"
  ];

  nativeBuildInputs = [ cmake ninja pkg-config ];
  buildInputs = [
    gtk3
    nasm
    libsecret
    libgcrypt
    freeglut
    libpulseaudio
    SDL2
    curl
    pugixml
    imgui
  ];
}

