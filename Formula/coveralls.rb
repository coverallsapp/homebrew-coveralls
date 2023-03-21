class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.16.tar.gz"
  sha256 "ec4cc1809cf1e6b19bd4d6ec3ced67f9330916189e9b37c0220414980e7d65ac"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.15"
    sha256 cellar: :any,                 monterey:     "3bb2a6118fb5fbb9dd26c8b7f76042355d103aff874fdc004ff4fa6e4630efdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "916d2220253e817c7debd118ab80b3681731b69e90c4cef313d11f53a87a0ffa"
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
