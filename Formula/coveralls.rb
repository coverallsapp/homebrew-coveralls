class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "e01c57e673911fada91b83ccc56412bc44af8f9d34efb5dabf89ce0a7060e80d"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.5.0"
    sha256 cellar: :any,                 monterey:     "160edc62a318e978ac9edb7b466a90a3a32d9f7bc63806cbb712c7580e3cea9c"
    sha256 cellar: :any,                 big_sur:      "736f58dce93aaa9850077375cd4aaa178c7d98de2455b4ba5f0b00f92b27d072"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "baa6a6a86fd5a5c7b74ffaf5cda8187e184a8490bf5fcdcebfdb7ac7582f2325"
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
