{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, libkrb5
, zlib
, xorg
}:

let
  cudaVersion = "11.6";
  releaseYear = "2022";
in
stdenv.mkDerivation rec {
  pname = "nvhpc";
  version = "22.3";

  src = fetchurl {
    url = "https://developer.download.nvidia.com/hpc-sdk/${version}/nvhpc_${releaseYear}_${builtins.replaceStrings["."][""] version}_Linux_x86_64_cuda_${cudaVersion}.tar.gz";
    sha256 = "1xdg6nj8r1si99wjfaqp1nc3mq77yg0cbm95drlxw655cwbqbs8r";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libkrb5 zlib libxkbcommon ] ++ with xorg; [ libxcb xcbutilkeysyms libX11 ];

  installPhase = ''
    runHook preInstall

    export NVHPC_SILENT=true
    export NVHPC_INSTALL_DIR=$out
    bash ./install
    mkdir $out/bin
    ln -s $out/Linux_x86_64/${version}/compilers/bin/* $out/bin/

    runHook postInstall
  '';
}
