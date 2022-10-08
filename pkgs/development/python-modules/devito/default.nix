{ stdenv
, lib
, buildPythonPackage
, fetchFromGitHub
, anytree
, nbval
, sympy
, scipy
, cached-property
, psutil
, py-cpuinfo
, cgen
, click
, multidict
, distributed
, pyrevolve
, codepy
, pytestCheckHook
, matplotlib
, pytest-xdist
}:

buildPythonPackage rec {
  pname = "devito";
  version = "4.7.1";

  src = fetchFromGitHub {
    owner = "devitocodes";
    repo = "devito";
    rev = "7827526fc8259952cec6e901ab4f188497f5950d";
    sha256 = "sha256-eK+gDOl0++13MQl+6HuVUe1DGxFfPy+/BG6c6zvhREU=";
  };

  postPatch = ''
    # Removing unecessary dependencies
    sed -e "s/flake8.*//g" \
        -e "s/codecov.*//g" \
        -e "s/pytest.*//g" \
        -e "s/pytest-runner.*//g" \
        -e "s/pytest-cov.*//g" \
        -i requirements.txt

    # Relaxing dependencies requirements
    sed -e "s/>.*//g" \
        -e "s/<.*//g" \
        -i requirements.txt
  '';

  checkInputs = [ pytestCheckHook pytest-xdist matplotlib ];

  # I've had to disable the following tests since they fail while using nix-build, but they do pass
  # outside the build. They mostly related to the usage of MPI in a sandboxed environment.
  disabledTests = [
    "test_assign_parallel"
    "test_gs_parallel"
    "test_if_parallel"
    "test_if_halo_mpi"
    "test_cache_blocking_structure_distributed"
    "test_mpi"
    "test_codegen_quality0"
    "test_new_distributor"
    "test_subdomainset_mpi"
    "test_init_omp_env_w_mpi"
    "test_mpi_nocomms"
  ];

  disabledTestPaths = [
    "tests/test_pickle.py"
    "tests/test_benchmark.py"
    "tests/test_mpi.py"
    "tests/test_autotuner.py"
    "tests/test_data.py"
    "tests/test_dse.py"
    "tests/test_gradient.py"
  ];

  propagatedBuildInputs = [
    anytree
    cached-property
    cgen
    click
    codepy
    distributed
    nbval
    multidict
    psutil
    py-cpuinfo
    pyrevolve
    scipy
    sympy
  ];

  pythonImportsCheck = [ "devito" ];

  meta = with lib; {
    broken = stdenv.isDarwin;
    homepage = "https://www.devitoproject.org/";
    description = "Code generation framework for automated finite difference computation";
    license = licenses.mit;
    maintainers = with maintainers; [ atila ];
  };
}
