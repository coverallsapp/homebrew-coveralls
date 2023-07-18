class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "b14eaa65b133f6cc6a63b1ed481d488a8c220cbe320ff2a3648074d12ac81655"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.3"
    sha256 cellar: :any,                 monterey:     "84ff81375c27fcc523c2dddf1af83b192ff901967a9387fe1af26ed5ee60fc5a"
    sha256 cellar: :any,                 big_sur:      "7d85dd4fe9746af2e278d8a0099375c9d2df8990018afcb0ea88846c4467d6b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b2a894be1166ebe15f32d494d5edf98b8d3ee521238da9c67fdc692129f6a04d"
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
