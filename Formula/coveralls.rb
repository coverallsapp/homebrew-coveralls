class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.15.tar.gz"
  sha256 "b29d4b2c61ebce695c35077099da3a53b72c1280f77da4a220288ff306508e79"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.14"
    sha256 cellar: :any,                 ventura:      "ab6b4363091e8fa9bbc8a9564f60e568850ed2bd48e17213c5ba524f6ffce4ae"
    sha256 cellar: :any,                 monterey:     "1297cfdf791ae7a8b1782b241911d408d45ff26e39efa550327a6eab814f815e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d63e1305e71eb57b76b0a818c390dec73f2dc9dbabab80c10ce4de3b37c7e646"
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
