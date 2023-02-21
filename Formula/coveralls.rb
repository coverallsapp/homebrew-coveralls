class Coveralls < Formula
  desc "Self-contained, universal coverage uploader binary for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "9b7263a310bf9df743d9668b10c0ae3a5ab7465c3927d4e7ee49d54243b4eb80"
  license "MIT"

  depends_on "crystal" => :build
  depends_on "libyaml"
  depends_on "libevent"
  depends_on "pcre"

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
