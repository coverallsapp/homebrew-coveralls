class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.6.tar.gz"
  sha256 "6831c8d9a2a21cc6ef24b2d50c892445069063d373b7cec5498d45f994120c43"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.5"
    sha256 cellar: :any,                 monterey:     "c82a42294112cb010228bb2b622507ca9c2f8d7bec8c069d22f650327ad3d94a"
    sha256 cellar: :any,                 big_sur:      "34a359853c240f7375343187cc8ffacbf80c539e8e33466e112ebf28095e4fc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "96f7bd72df66af9f8324db6f5728c27b1917a70abae3c0216c7b2ff980127b74"
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
