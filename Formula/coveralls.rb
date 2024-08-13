class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.13.tar.gz"
  sha256 "ed2d8aaef3363a87b52bb1d1cbc09c8f456a13e698872efacea90677e90015ca"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.12"
    sha256 cellar: :any,                 monterey:     "d84c47907f4936ece239d7c9e7f0b055f5d09e39eb269b2a5699a2bb811fc4e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8c0d63b7de97ab3cbe303f6ca40901358f2d338523f7b45cb6847955e1c98a13"
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
