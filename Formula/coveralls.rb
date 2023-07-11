class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "29fac6a48cffd9224b04b4d928bb6d8cfd95d41345a6746333dd028195b018b5"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.0"
    sha256 cellar: :any,                 monterey:     "7dd186ff3439bfb7cd0df231ba5d8a93590a104b7fe37d2d46ff9e2243e3cced"
    sha256 cellar: :any,                 big_sur:      "b3d82206407d1940b7ed43389206b9f1532fe8a38ae6ff35a6836fa921e90a99"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f6b4a8f6f646c8508a9f14226aa17aea4084a80f2c44dbe067afa9d0bd6393f0"
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
