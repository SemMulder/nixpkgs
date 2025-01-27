{ lib, stdenv
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, libiconv
, Security
, SystemConfiguration
}:

rustPlatform.buildRustPackage rec {
  pname = "monolith";
  version = "2.8.0";

  src = fetchFromGitHub {
    owner = "Y2Z";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-TYLQkVVjIFr6BrPaKJSHDnLAK0HQuI3Pmi2IkWVoIn4=";
  };

  cargoHash = "sha256-NIKueum/BQEW21e8/DGadtwylXeT3Vl2TOVbbxxWkLY=";

  nativeBuildInputs = lib.optionals stdenv.isLinux [ pkg-config ];
  buildInputs = lib.optionals stdenv.isLinux [ openssl ]
    ++ lib.optionals stdenv.isDarwin [ libiconv Security SystemConfiguration ];

  checkFlagsArray = [ "--skip=tests::cli" ];

  meta = with lib; {
    description = "Bundle any web page into a single HTML file";
    homepage = "https://github.com/Y2Z/monolith";
    license = licenses.unlicense;
    maintainers = with maintainers; [ Br1ght0ne ];
  };
}
