class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.15.tar.gz"
  sha256 "f22e82726b4f67c255463cd45976b78e101f5b02273f3518e9bd2b058ff8b3dd"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.14"
    sha256 cellar: :any,                 monterey:     "3e7a79b720cb87e92a1150fcc12704018496d78d6c4e04d95fce5a11cd662b36"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8bb0723aefbad4129263f4a8dc0bceb25e31e17a11fd4384edf5d3b007e8f453"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre"
  depends_on "sqlite"

  uses_from_macos "libxml2"

  def install
    system "shards", "install", "--production"
    system "crystal", "build", "src/cli.cr", "-o", "./dist/coveralls", "--release", "--no-debug"
    system "strip", "./dist/coveralls"
    bin.install "./dist/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
