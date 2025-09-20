class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.17.tar.gz"
  sha256 "24b4e10efb0be269b924877860bfd673588b3ab7f1e8dcf36257db332a6853a9"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.16"
    sha256 cellar: :any,                 arm64_sequoia: "810b1ac343f38db2935b84277c9f88d63aad44a030e5fe1171083c120bf2217d"
    sha256 cellar: :any,                 arm64_sonoma:  "920b3e323ccd11e3ebd00f2872bd5c041afb70e7b7310edb6d740ea33340f72b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e42188dd5ab22f0235564aec287ec2f852cf1bdcc8ddba56de614725563eb272"
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
