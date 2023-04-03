class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.18.tar.gz"
  sha256 "0f094229815bca8f0c255bc6d04239927a1c12a0e8a307702fbc1971f60b0fac"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.17"
    sha256 cellar: :any,                 monterey:     "14207206c0c160bcdf39aeaf2039fac32747bf7a48adea2f63572118ca2382b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cdc06a243e349a0664698d17bb22fa3fae8d3823b6fcc201801c003708486e81"
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
