{ lib
, stdenv
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, cmake
, numpy
, gfortran
, scikit-build
, versioneer
}:

buildPythonPackage rec {
  pname = "sotb-wrapper";
  version = "unstable-2022-08-23";

  src = fetchFromGitHub {
    owner = "ofmla";
    repo = "seiscope_opt_toolbox_w_ctypes";
    rev = "61d48b2c4877a90a934b55b96aebd35e2ac99b26";
    sha256 = "sha256-bijXQNv2Hasz/D3Nx95Gt8nGU06GAOeHpEGRgj8MUN8=";
  };

  dontConfigure = true;

  # Fixing relative paths
  wrapperInstallDir = "$out/lib/python3.10/site-packages/sotb_wrapper";
  postPatch = ''
    substituteInPlace test/test_correctness.py \
    --replace "f\"{pkg_folder}/sotb_wrapper\"" "\"$out/lib/python3.10/site-packages/sotb_wrapper\""
  '';

  nativeBuildInputs = [
    scikit-build
    cmake
    gfortran
  ];

  buildInputs = [ versioneer ];

  propagatedBuildInputs = [
    numpy
  ];

  checkInputs = [
    pytestCheckHook
  ];

  # Also fixing relative paths
  postInstall = ''
    substituteInPlace ${wrapperInstallDir}/interface.py \
    --replace "Path(__file__).parent" "\"${wrapperInstallDir}/\"" \
    --replace "str(path / name)" "path + name"

    substituteInPlace /build/source/sotb_wrapper/interface.py \
    --replace "Path(__file__).parent" "\"${wrapperInstallDir}/\"" \
    --replace "str(path / name)" "path + name"
  '';

  pythonImportsCheck = [ "sotb_wrapper" ];

  meta = with lib; {
    description = "A wrapper to the SEISCOPE optimization toolbox Fortran code from Python";
    homepage = "https://github.com/ofmla/seiscope_opt_toolbox_w_ctypes";
    license = licenses.mit;
    maintainers = with maintainers; [ atila ];
  };
}
