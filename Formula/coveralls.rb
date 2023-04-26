class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.8.tar.gz"
  sha256 "419c1c9c4995b9ab19291f9f1b89a3e0a55bde95c4406167d3340ef02f96c9b4"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.8"
    sha256 cellar: :any,                 monterey:     "944ccc330590face4118953a4a64258a4bbbd543561fcbb550149315575e8c91"
    sha256 cellar: :any,                 big_sur:      "a85f012fc6bcd84a7d578d16181c29618a36aca812294a79a4517bc52bf39ae0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f127ca23d4c23aaeff6aa7742e6b1707a87de3f85873c50ec50c05a429b3d81e"
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
