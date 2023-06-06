class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.6.tar.gz"
  sha256 "6831c8d9a2a21cc6ef24b2d50c892445069063d373b7cec5498d45f994120c43"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.6"
    sha256 cellar: :any,                 monterey:     "78c47840a2246d177324269069c9ae305c96b8b6aff9f6421dbd3b7c0cae1ce4"
    sha256 cellar: :any,                 big_sur:      "f1e54e12a139ca59ca272734fd99dbea411af5e0a5b94507cb6a4205ef5e4901"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aaf6493a3d7917098f43f17a9ce7613041c175c00c262796b12df1acbb714f35"
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
