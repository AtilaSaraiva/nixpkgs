
{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, emcee
, numpy
, hankel
, meshio
, pyevtk
, cython
}:

buildPythonPackage rec {
  pname = "gstools";
  version = "1.4.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "GeoStat-Framework";
    repo = "GSTools";
    rev = "v${version}";
    sha256 = "sha256-NaXV1P8fIiEoac3wok+FpwIKcbQ2Kp4yfZBQYo0u+9M=";
  };

  buildInputs = [
    cython
  ];

  propagatedBuildInputs = [
    emcee
    numpy
    hankel
    meshio
    pyevtk
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "gstools" ];

  meta = with lib; {
    description = "GSTools - A geostatistical toolbox: random fields, variogram estimation, covariance models, kriging and much more";
    homepage = "https://geostat-framework.org/";
    license = licenses.lgpl3;
    maintainers = with maintainers; [ atila ];
  };
}
