class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "9aa971f59b8d336b4a9cb270dcd6c12bf4f0b9161e1733d555fe1db049ad5380"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.0"
    sha256 cellar: :any,                 monterey:     "314bbd5f9f413ffd30c21faa39ce006731340ac497363ddd2ebad79d64b297d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e9803f1decfd6641bfb11ea23871523729c217ef335594e44465e876220d6cf"
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
