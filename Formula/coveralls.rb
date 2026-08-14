class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.19.tar.gz"
  sha256 "6d61c07ed563229660d81b3c9eb899253180bfc911553eb382c625af88f15549"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.18"
    sha256 cellar: :any, arm64_tahoe:  "8eaf2706c3772f22d53779bb9769e0532341488b39349c6b0b48ada396151633"
    sha256 cellar: :any, arm64_sonoma: "8ede71b4344b52e6e87d2d5ddf29343b54e4fb92877e8cd51b7a0588bdc64b59"
    sha256 cellar: :any, x86_64_linux: "3916d5c6b595144b7edffef17c169095cdbee68000a5df1c0fd8f12914f81e27"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "sqlite"

  uses_from_macos "libxml2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "shards", "build", "coveralls", "--production", "--release", "--no-debug"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
