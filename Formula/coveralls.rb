class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "b60fe1673ab0c9404f6b66a26889366d91725dc861db1aaf3486b65eb5ad286c"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.5.2"
    sha256 cellar: :any,                 monterey:     "99d859f42b2d21775c29eac5d783f45e07174754793699339200b5521c07b32c"
    sha256 cellar: :any,                 big_sur:      "62569009247b78ebea0ec1cccaf5775616197f91d7df6588ebbc7844b79582cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "51d6815131499492d9fc4e1f7a80d3a89fc4365c95433055fe488a20e8e328eb"
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
