class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "fc7239b15993e325f37a274345047bb622ed07199d453dc972923cf69d5f1bd5"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.7"
    sha256 cellar: :any,                 monterey:     "318c3026d379fd9e884a8f064dc33b512ee9c712117328eeeb5c3c91d75aa8e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "99d707486c4f8c043ffd24ad9608b6ad648541dcb750bfb13b4dacbdbd6c8387"
  end

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
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
