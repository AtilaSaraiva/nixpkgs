{ llvmPackages
, stdenv
, lib
, fetchFromGitHub
, cmake
, libpng
, libjpeg
, mesa
, eigen
, openblas
, blas
, lapack
, ninja
, python
, enablePython ? false
}:

assert blas.implementation == "openblas" && lapack.implementation == "openblas";

stdenv.mkDerivation rec {
  pname = "halide";
  version = "14.0.0";

  src = fetchFromGitHub {
    owner = "halide";
    repo = "Halide";
    rev = "v${version}";
    sha256 = "sha256-/7U2TBcpSAKeEyWncAbtW6Vk/cP+rp1CXtbIjvQMmZA=";
  };

  cmakeFlags = [ "-DWARNINGS_AS_ERRORS=OFF" "-DTARGET_WEBASSEMBLY=OFF" ] ++ [(if enablePython then "-DWITH_PYTHON_BINDINGS=ON" else "-DWITH_PYTHON_BINDINGS=OFF")];

  # Note: only openblas and not atlas part of this Nix expression
  # see pkgs/development/libraries/science/math/liblapack/3.5.0.nix
  # to get a hint howto setup atlas instead of openblas
  buildInputs = [
    llvmPackages.llvm
    llvmPackages.lld
    llvmPackages.openmp
    llvmPackages.libclang
    libpng
    libjpeg
    mesa
    eigen
    openblas
  ] ++ lib.optional enablePython python.pkgs.pybind11;

  nativeBuildInputs = [ cmake ninja ] ++ lib.optional enablePython python;

  meta = with lib; {
    description = "C++ based language for image processing and computational photography";
    homepage = "https://halide-lang.org";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ ck3d atila ];
  };
}
