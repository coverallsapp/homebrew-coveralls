class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "799e99cca5ca25114c4ff69489a1bc63949f8871b8b86a16a7232d9b7f5f33cf"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.4"
    sha256 cellar: :any,                 monterey:     "054cc4703d3b54500b8c6751d1a9ae092b267c28c15218260c0b4c1115c0fc64"
    sha256 cellar: :any,                 big_sur:      "3d8731fcff5292c21fcc99bb04aa09d0efdfa409eba2d26ca0ff354ab22299a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "163148981535664c8b5a28bba53c20abfdb5c81b67b26f55e8e38f887225760c"
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
