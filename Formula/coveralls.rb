class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "e01c57e673911fada91b83ccc56412bc44af8f9d34efb5dabf89ce0a7060e80d"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.5.1"
    sha256 cellar: :any,                 monterey:     "eb307c235eedb98581417c4e387e02808b3a90860bf292fcf15dfc67fd3afce6"
    sha256 cellar: :any,                 big_sur:      "4fadc5aad43a1bb06ecc6bda0bc02f8e74af34545b49e5f2c55e17cf1e009826"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d28de84de93f80c7bc67f404e6662dfebffec64bdfd7fe46170fc54410012485"
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
