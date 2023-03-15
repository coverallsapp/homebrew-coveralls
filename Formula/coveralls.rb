class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.12.tar.gz"
  sha256 "4f7e7720a8cf113bc7729cb287eac4de4e81b9172ff4f0895ec3b0efc67a2e0d"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.12"
    sha256 cellar: :any,                 monterey:     "409ea51788c66d222dbe2b9a2b21b0567daa1a7ec215698134c1dea1d27cf8ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cde0047b643cff8b4ed8e38b8567c0db7db4ad54d5d8976d87c36c28d1ebbd88"
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
