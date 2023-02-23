class Coveralls < Formula
  desc "Self-contained, universal coverage uploader binary for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "8569060029c9175180bda08bd52f5079486f0cf58cc13b9d531a4fde349f6fd6"
  license "MIT"

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre"

  uses_from_macos "libxml2"

  def install
    system "shards", "install", "--production"
    system "crystal", "build", "src/cli.cr", "-o", "./dist/coveralls", "--release", "--no-debug"
    system "strip", "./dist/coveralls"
    bin.install "./dist/coveralls"
  end

  test do
    assert_match version, shell_output("#{bin}/coveralls --version")
  end
end
