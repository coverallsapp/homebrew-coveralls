class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "5a93aba64d53e6744ada144f70a18b5bc2b0a1c88f461cfa00ffef017d8e1be0"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.3"
    sha256 cellar: :any,                 monterey:     "fdfdfa67dbed70e3dc0ec5be71d61f072d21b094e607577619763a73603267bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ced1ad68804c4a91403f7f6e034a85e0f363f0d178e71386370262d80ddd6d5d"
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
