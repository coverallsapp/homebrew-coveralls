class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.22.tar.gz"
  sha256 "b513648b0721c18abe635b62b04d955bf50c05e4dcb58abc023ac41e48ad504b"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.21"
    sha256 cellar: :any, arm64_tahoe:  "b6e9cc2ac45a76d96b60431ca94acfea00144393f880bad4427471817c88d5ba"
    sha256 cellar: :any, arm64_sonoma: "db16ac1c7b09878cc68e2646ea2d512b7833dc8fdc4966081b75e4fd5fa3786d"
    sha256 cellar: :any, x86_64_linux: "4af092ca397c8a0efc5f8da7f1c6b528cce522ed9da5dcd8606473597b7dd492"
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
    # `-Dwithout_mt` is required, not an optimization.
    #
    # Crystal 1.21 enables execution contexts (RFC 0002) by default. That
    # runtime starts a bare `SYSMON` monitor thread which has no execution
    # context of its own; it races with main-thread initialization and aborts
    # the process at random with:
    #
    #   Unhandled exception: Thread#execution_context cannot be nil
    #
    # That shipped in the 0.6.19 and 0.6.20 bottles and broke user CI jobs.
    # Upstream regression: https://github.com/crystal-lang/crystal/issues/17212
    #
    # Upstream pinned its own builds to Crystal 1.20.3, but Homebrew builds
    # this formula with whatever `crystal` resolves to (1.21.0 today), so the
    # pin does not reach us. `-Dwithout_mt` selects the pre-1.21 single-threaded
    # runtime and removes the SYSMON thread entirely.
    #
    # Drop this once crystal-lang/crystal#17212 is fixed and released. Verify by
    # confirming `strings bin/coveralls | grep SYSMON` returns nothing.
    system "shards", "build", "coveralls", "--production", "--release", "--no-debug", "-Dwithout_mt"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
