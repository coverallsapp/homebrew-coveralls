class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "9aa971f59b8d336b4a9cb270dcd6c12bf4f0b9161e1733d555fe1db049ad5380"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.1"
    sha256 cellar: :any,                 monterey:     "def5cf673579d02900665b928ae58422177e823513e9332c89dd3f1a534eb9ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "194cc5e15c97d9242f849449efeb3c13a1a4c00085c90fc9b7e97f6347dbcaea"
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
