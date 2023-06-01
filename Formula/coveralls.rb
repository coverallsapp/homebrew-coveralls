class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.4.tar.gz"
  sha256 "9dc0ef5d942c238a93e8dd2cb0c5178f2b439cd4c5fe39645a3e1a655bca960a"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.3"
    sha256 cellar: :any,                 monterey:     "3c4451062da5e42af486dde3b9d593be8d2458ac235e0a1ccb94ff694720372d"
    sha256 cellar: :any,                 big_sur:      "b0c73c58b107f9d69a6afd656f9ffbe56556f36548b4668f7b16f4735f774964"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d22b0de5041772817920a769a7e78c03261f5ec5aa2a09a297bf71dabedbe04e"
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
