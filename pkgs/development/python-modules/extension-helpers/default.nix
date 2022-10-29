{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, setuptools
}:

buildPythonPackage rec {
  pname = "extension-helpers";
  version = "1.0.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "astropy";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-wFWe9OTl1RuTHWh3yyYtl0wmUMA1wOl0IgHeIiCxvUg=";
  };

  buildInputs = [ setuptools ];

  propagatedBuildInputs = [

  ];

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "extension_helpers" ];

  meta = with lib; {
    description = "Helpers to assist with building Python packages with compiled C/Cython extensions";
    homepage = "https://github.com/astropy/extension-helpers";
    license = licenses.bsd3;
    maintainers = with maintainers; [ atila ];
  };
}
