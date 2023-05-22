class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "c9c1fd2b8f6ec77a9e4e6b142a849522cb4131f841b24eaa82df0c471ad42593"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.4.1"
    sha256 cellar: :any,                 monterey:     "a89dcbf08c35ba0550a33fe7d9a5c87b89aa91406ab552c5fd0e3f387788c7db"
    sha256 cellar: :any,                 big_sur:      "8bdea9ca3e114fd27a5f56c3705e8918ac8b3e3f91c6f7ac34242cd2e33a1cf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dff8a8e8991050efb1bc2e226b394ac57700f4f7f512f4cf5aecec9b2545c150"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre2"
  depends_on "sqlite"

  uses_from_macos "libxml2"

  def install
    system "shards", "build", "coveralls", "--production", "--release", "--no-debug"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
