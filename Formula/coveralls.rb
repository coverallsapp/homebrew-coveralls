class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.20.tar.gz"
  sha256 "3c294b1ce0af462b844680416fc3e352bc3b3fb8e56e0d1e3ff3f0d948c2699e"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.20"
    sha256 cellar: :any, arm64_tahoe:  "01946ccd20ff1e77e6c83c25761eb104aac8fdb9b5dd52f08fdce758ef5c366a"
    sha256 cellar: :any, arm64_sonoma: "a5aa703057ff454147d49f6423a0e114ed0c90e333894564c21d4085eef801bc"
    sha256 cellar: :any, x86_64_linux: "9c342ea30433d187d401019c9b7287291ede3635bd1a5e72ca9d2aaf8a775e96"
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
