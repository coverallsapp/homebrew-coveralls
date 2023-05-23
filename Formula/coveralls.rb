class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "660f982541d8bdb00d7e53164e5cbb159562f95c5fcb582c4c60ff956a984201"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.2"
    sha256 cellar: :any,                 monterey:     "63c1bf23b50570a4e8a39965b6215c0062d1326d3cc2264e4725ce16e885959a"
    sha256 cellar: :any,                 big_sur:      "409c39d69aaee64772e18e7955c4e5aff86888cf84c92968ece789240a66b11c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62ce9347ef65d372c8b3a05039a76a535bd2c1048d89bf7edb7c162d2b78bcc3"
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
