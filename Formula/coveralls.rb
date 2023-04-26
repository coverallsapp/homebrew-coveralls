class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.7.tar.gz"
  sha256 "62e65641b7ea0969667ebfe266da4cb35cacf014d57c3508f1075a4c942c7b21"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.7"
    sha256 cellar: :any,                 monterey:     "c536e824fd6cfaeb9393d4bc92661817c5ca4ff20a71fe39c8cdedca6b8b12dd"
    sha256 cellar: :any,                 big_sur:      "e2c587f842f3bc0ad97940c1f4fde8a496b6007ce089655ecf51d42c04494df6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b8082bf86ae71e0fc26b01ba63ae780685764bb9dd038408ce65325f93fc5354"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre2"
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
