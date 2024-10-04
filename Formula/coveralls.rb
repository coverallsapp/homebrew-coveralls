class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.15.tar.gz"
  sha256 "b29d4b2c61ebce695c35077099da3a53b72c1280f77da4a220288ff306508e79"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.15"
    sha256 cellar: :any,                 arm64_sonoma:  "49ba6c2386ffc17a03aee5483f41c2ba03e272d8224e9165a1bdf10307fcd9a8"
    sha256 cellar: :any,                 ventura:       "5fadee64a25c83f610c9583ca86d865262f6dff6bad951f7bc3a73c6caebdd52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "819b980135dad736042713d4fe949fec793b5e26028b6364e808413091dd1cb7"
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
