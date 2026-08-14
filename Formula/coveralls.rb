class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.19.tar.gz"
  sha256 "6d61c07ed563229660d81b3c9eb899253180bfc911553eb382c625af88f15549"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.19"
    sha256 cellar: :any, arm64_tahoe:  "6139bc430f92ae9b534c621b82f119cd6634e18c6039c7877477fed6ac73e6ea"
    sha256 cellar: :any, arm64_sonoma: "26b62f154729dfeaca49d0fa522800e67543c2e7c71bcfd2afd27a8ff083e8db"
    sha256 cellar: :any, x86_64_linux: "41454cb0b7649518d0dd2fe9f06a62bd1e5fdf8d7f6540c6e3a1a6bbef6c9040"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "sqlite"

  uses_from_macos "libxml2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "shards", "build", "coveralls", "--production", "--release", "--no-debug"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
