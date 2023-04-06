class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.20.tar.gz"
  sha256 "f713557df0d835f559f4ce719a166ca35452a37468773917d489c00c0f73c554"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.20"
    sha256 cellar: :any,                 monterey:     "178497c806fb8831b789fd96ad07d88e0d9ddba8f907d3a48d3e86ac2070c2ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5e783a24d32e807e5bb61efb445f474cfc889e23f9541da0cd27322f8e377aed"
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
