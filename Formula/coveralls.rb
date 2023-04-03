class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.18.tar.gz"
  sha256 "0f094229815bca8f0c255bc6d04239927a1c12a0e8a307702fbc1971f60b0fac"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.18"
    sha256 cellar: :any,                 monterey:     "08ec1091daf0d40b51e7dd8683b75921149a9e6b26d7726d689aa9b8e8d139e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3be9404b10f0fa41c17e8ad71bdb0e021d1b12c2ba186268b36ee1fa5b7241a0"
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
