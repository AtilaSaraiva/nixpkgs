{lib
, buildPythonPackage
, fetchFromGitHub
, pythonRelaxDepsHook

# install requirements
, certifi
, six
, python-dateutil
, setuptools
, urllib3
, pyyaml
, aiohttp

# test requirements
, asynctest
, codecov
, flake8
, isort
, mock
, pluggy
, py
, pytestCheckHook
, pytest-cov
, pytest-xdist
, recommonmark
, sphinx
}:

buildPythonPackage rec {
  pname = "kubernetes-asyncio";
  version = "23.6.0";

  src = fetchFromGitHub {
    owner = "tomplus";
    repo = pname;
    rev = version;
    sha256 = "sha256-g1pAA8Po0xv29Jp5MkKTS1KbouXEu38SVC3DuHR1iwg=";
  };

  postPatch = ''
    sed -e "s/randomize.*//g" -i test-requirements.txt
  '';

  nativeBuildInputs = [ pythonRelaxDepsHook ];
  pythonRelaxDeps = true;

  propagatedBuildInputs = [
    certifi
    six
    python-dateutil
    setuptools
    urllib3
    pyyaml
    aiohttp
  ];

  checkInputs = [
    asynctest
    codecov
    flake8
    isort
    mock
    pluggy
    py
    pytestCheckHook
    pytest-cov
    pytest-xdist
    recommonmark
    sphinx
  ];

  disabledTestPaths = [
    "kubernetes_asyncio/e2e_test"
  ];

  doCheck = true;
}
