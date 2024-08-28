class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.14.tar.gz"
  sha256 "32ddfdd3d6b9001ccf394d9679c919f506eb35cb83dcba8fd17ba2c898bff027"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.13"
    sha256 cellar: :any,                 ventura:      "3db6f70039c236c3fc75b657b91c1d937bc55023a388b9016f62fbed385f357f"
    sha256 cellar: :any,                 monterey:     "39f579fcbf78408831cd1969a4bb435a0f4fa768a3fdc7071c616c672d2fd417"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5ec8be0e17b69c934537c07f672b402f08c375bb0bbc0f96518106a9a31b8199"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre2"
  depends_on "sqlite"

  uses_from_macos "libxml2"

  def install
    system "shards", "build", "coveralls", "--production", "--release", "--no-debug"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
