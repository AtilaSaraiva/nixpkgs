{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, gnome
, gtk4
, desktop-file-utils
, appstream
, gjs
, libadwaita
, wrapGAppsHook4
, gnome-desktop
}:

stdenv.mkDerivation rec {
  pname = "juction";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "sonnyp";
    repo = "Junction";
    rev = "v${version}";
    sha256 = "sha256-jS4SHh1BB8jk/4EP070X44C4n3GjyCz8ozgK8v5lbqc=";
  };

  nativeBuildInputs = [
    meson
    ninja
    wrapGAppsHook4
  ];

  buildInputs = [
    gnome-desktop
    desktop-file-utils
    gjs
    gtk4
    libadwaita
  ];

  # error: unsupported interpreter directive "#!/usr/bin/env -S gjs -m"
  # (set dontPatchShebangs=1 and handle shebang patching yourself)
  dontPatchShebangs = true;

  postFixup = ''
    substituteInPlace $out/bin/.re.sonny.Junction-wrapped --replace \
    "gjs" "${gjs}/bin/gjs"
  '';

  meta = with lib; {
    description = "Application/browser chooser";
    homepage = "https://apps.gnome.org/app/re.sonny.Junction/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ atila ];
    platforms = platforms.linux;
  };
}
