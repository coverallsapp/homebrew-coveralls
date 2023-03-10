class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.10.tar.gz"
  sha256 "e5a240fd2d414a0a24ed8cdfb3eb21c9e6aa45a802aaaaa30c245b90fd38d3c4"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.8"
    sha256 cellar: :any,                 monterey:     "c64ee864853b1b95321a139a304708315d17e3c5ff08d461081caf6384c7fbb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "756639479dd95126f6eeb2d612b484453e8f1b9556ffc9362edfedccda31be68"
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
