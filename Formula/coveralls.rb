class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "343c04c1b3859f16ab4413657b44c50951fdeca63ca4d52c63afd36176a74514"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.2"
    sha256 cellar: :any,                 monterey:     "c45194ff09f2f901959494bbcd199f08aa88d15854c0c97821379e3aca0037d9"
    sha256 cellar: :any,                 big_sur:      "b31a87c53807f6ee08773a5590c149fbfbd7099a85228660cd1a1aacfd5c4fc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab67684cb4d00beeb0962cb418b764edf18b0c735fcd362bb60c768343c5b146"
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
