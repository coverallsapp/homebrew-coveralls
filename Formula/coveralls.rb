class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.17.tar.gz"
  sha256 "24b4e10efb0be269b924877860bfd673588b3ab7f1e8dcf36257db332a6853a9"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.17"
    sha256 cellar: :any,                 arm64_sequoia: "8278f6b87c594c0ce55219afaf623cf8aaf5fe1b7af0cc2313e71779b5675f6e"
    sha256 cellar: :any,                 arm64_sonoma:  "0fc8d9f5757972ddd2ca99047f11937025b8bb03024d248adffd61f7aacedbc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8f46bbd13ba931cf0352711bcee4c72f3eef7503b921a8960af9bbf27d225e3"
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
