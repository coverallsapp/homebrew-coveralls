class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "17f424712d9a0ebbd62ef610e6416254028a790c566f2f40e4ae374eadf88408"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.5"
    sha256 cellar: :any,                 monterey:     "64efcf8867220f85b954ecfe3bca200a9f84051fffd7b36d2bc5d9af7cb7c6f5"
    sha256 cellar: :any,                 big_sur:      "92966c48be8675b51f10d3dc5e01b488684930dffce792cd8a27cca4eb681d33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b892c29d635f0fdeb9e97821c86452016b662138b9effb4396a3debf878141a"
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
