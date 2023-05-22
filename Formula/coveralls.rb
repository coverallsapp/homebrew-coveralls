class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c9c1fd2b8f6ec77a9e4e6b142a849522cb4131f841b24eaa82df0c471ad42593"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.0"
    sha256 cellar: :any,                 monterey:     "7921f9ac45c95ff122849dc4119e4182380c0cf37f66532ec0bc1f4a817c45bb"
    sha256 cellar: :any,                 big_sur:      "36ff86ad79d40928447215e0ac12aaa82166b95f687b632e753bc154cbf8f623"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ed5ec0b4603c7f71ad58662cbac129db882ca9559a11f49d84f07192a58f9e42"
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
