{ lib
, stdenv
, fetchurl
}:

let
  cudaVersion = "11.6";
  releaseYear = "2022";
in
stdenv.mkDerivation rec {
  pname = "nvhpc";
  version = "22.3";

  src = fetchurl {
    url = "https://developer.download.nvidia.com/hpc-sdk/${version}/nvhpc_${releaseYear}_${version}_Linux_x86_64_cuda_${cudaVersion}.tar.gz";
  };
}
