class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.10.tar.gz"
  sha256 "e3bc728c10e1dc93eae1a4ade717dcc418d267cab37226b7e208a3a6557461af"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.9"
    sha256 cellar: :any,                 monterey:     "3b667aadd98ce6abc700450afafa6a5e8570c64ec4d301f36654d4b912e5dcae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4dd15a1c0bf135f324fe7dae9c9124d1ea726eb5c5108bc614eb5c5991251062"
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
