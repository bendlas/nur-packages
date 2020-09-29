{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "lsd-${version}";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "Peltoche";
    repo = "lsd";
    rev = "${version}";
    sha256 = "006fy87jrb77cpa6bywchcvq1p74vlpy151q1j4nsj8npbr02krj";
  };

  cargoSha256 = "0mrvcca9y0vylcrbfxxba45v05qxd8z91vb4in88px60xah0dy3q";

  meta = with stdenv.lib; {
    description = "The next gen ls command";
    homepage = https://github.com/Peltoche/lsd;
    license = licenses.asl20;
    maintainers = [ maintainers.bendlas ];
    platforms = platforms.all;
  };
}
