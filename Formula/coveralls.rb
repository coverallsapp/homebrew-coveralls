class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "c8317e885220550a6d23099d55aa6ac944cf60ac2992db2af0363ccee41996e2"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.9"
    sha256 cellar: :any,                 monterey:     "2f274f6911b07666a589eb7897cbef8f24167313a2f65059a11c42c4dcbf8b00"
    sha256 cellar: :any,                 big_sur:      "4841d60d53da6c6a2e180527596f68f5e366ce7524fb6cf73dd78ac0e25d60e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8c9c8ce72d381fece8a33bc809855e33e8bb7a7be7cfc8eaa745de12b0030836"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre2"
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
