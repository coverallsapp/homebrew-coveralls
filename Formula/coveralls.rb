class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.7.tar.gz"
  sha256 "62e65641b7ea0969667ebfe266da4cb35cacf014d57c3508f1075a4c942c7b21"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.6"
    sha256 cellar: :any,                 monterey:     "2b9efbb1ce822d5be2738982abe5965631bac00511e0bea65f20f3b56b97efd8"
    sha256 cellar: :any,                 big_sur:      "c2eae5afd21753330de8ebbcf11a930cdd78a5f395d908efa017718c5d69c75c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1305dcdda695f61f2e7390df4490671ac486e493eb9bbb66a6f6a81fe3441882"
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
