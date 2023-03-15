class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.13.tar.gz"
  sha256 "a49e88d1078edae3821351db20e860a6a78867d4970a7e208cf0aea28c59386a"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.13"
    sha256 cellar: :any,                 monterey:     "752087fd3075f31b941483c3d62946cbce1cb986dbac5d970d0372148b003b68"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "13750a86f48607eb9d5cd30b79fa3ef27fbbe7ac075ba9e554e52ab4414cf8ff"
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
