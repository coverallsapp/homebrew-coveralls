class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.4.tar.gz"
  sha256 "9dc0ef5d942c238a93e8dd2cb0c5178f2b439cd4c5fe39645a3e1a655bca960a"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.4"
    sha256 cellar: :any,                 monterey:     "f461307251c8d03b765df79bc1959e3b73e74b550d6a1385e02b4680e5091cfc"
    sha256 cellar: :any,                 big_sur:      "86d5be275b1a42fc53d58412b927241d674d22892a0ecb75ed51e19d322cc903"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec2b7527303ecfd06d680bc99979996fa5915f13ac1c12cbb44ce189dca4408e"
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
