class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.10.tar.gz"
  sha256 "e3bc728c10e1dc93eae1a4ade717dcc418d267cab37226b7e208a3a6557461af"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.10"
    sha256 cellar: :any,                 monterey:     "cb9eecaa7ed676fdc77bdb81916b6ae2405d75fd6fd2d635cfe1646128c63e28"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4e1fe23d3d2adf4887018dc43363b4a2a20aab759cd5a0cf10d401bf67b7cd3d"
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
