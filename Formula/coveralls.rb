class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.12.tar.gz"
  sha256 "4f7e7720a8cf113bc7729cb287eac4de4e81b9172ff4f0895ec3b0efc67a2e0d"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.10"
    sha256 cellar: :any,                 monterey:     "7dc49b7374f89a092830a7dc36eef1871ac3ec81800754696c2cb6001cc858ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0489113f89e4e5094d0e4ea899154d206b43a49233aa08402377a22c0c3ec2ba"
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
