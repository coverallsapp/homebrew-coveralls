class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.15.tar.gz"
  sha256 "b29d4b2c61ebce695c35077099da3a53b72c1280f77da4a220288ff306508e79"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.15"
    sha256 cellar: :any,                 arm64_sonoma:  "6ca174fe2a7b2fb68d7c3fe786aea03a234e4d78c49f452e724885c80d89b5d9"
    sha256 cellar: :any,                 ventura:       "63968457a0c123ab68972e96f8d265634bbd06c357d56f6f30b2005b9ac6c017"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1a657b849815801ec68a578179eb95e78c7cda2b9070cf93a54882c7638272e"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "sqlite"
  depends_on "zlib"

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
