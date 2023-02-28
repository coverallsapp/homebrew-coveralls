class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "30ec9c03fc0c2d02051f87a8446040d610723f166262d05f4e9e4fbe407fa637"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.4"
    rebuild 1
    sha256 cellar: :any,                 monterey:     "3d3c5c2afdac21b4d507db9dfa4a0a720dfe35cb623a5918646bec343527ed46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42454b2727b3ca1a1a4923035a5d2208309f4b1c9743f5c418dd620f5018fcce"
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
