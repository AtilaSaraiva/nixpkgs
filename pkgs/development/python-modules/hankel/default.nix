{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, setuptools
, scipy
, mpmath
}:

buildPythonPackage rec {
  pname = "hankel";
  version = "1.1.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "steven-murray";
    repo = "hankel";
    rev = "v${version}";
    sha256 = "sha256-p0g3Lntu3B1wIjyrlu6L4STvH6IaJTnIohlOlu7z7m0=";
  };

  buildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    scipy
    mpmath
  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "hankel" ];

  meta = with lib; {
    description = "Implementation of Ogata's (2005) method for Hankel transforms";
    homepage = "https://github.com/steven-murray/hankel";
    license = licenses.free;
    maintainers = with maintainers; [ atila ];
  };
}
