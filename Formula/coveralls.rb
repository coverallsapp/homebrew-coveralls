class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.14.tar.gz"
  sha256 "2ea4d0c9dce2e7f170d46b53dabd223c3ab17c1f8d77106bec33dd7911180f71"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.14"
    sha256 cellar: :any,                 ventura:      "bb67840353b7ee5cfbc260bce2c1205de7e5f1107a64c44110289e4c4a1cecb4"
    sha256 cellar: :any,                 monterey:     "4e148c6570c4d7568527265edf62005dbb3cffe994f602a7c9122851d71c2c60"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62f4464d271b7d7f6aba8400b66d987f38e2b3a82889a4e3bbe030533c9853d9"
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
