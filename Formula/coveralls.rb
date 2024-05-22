class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.12.tar.gz"
  sha256 "3eb819396ab4d31f4113caaefd0a4d77f6b9b58fa03ee42af975071c33927bde"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.11"
    sha256 cellar: :any,                 monterey:     "559f01d19cef67b78c27c51f6adab36f960184f4808f6770b864356a9219032f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "545c1441b26acb0d7b230cfbd7707564ec1eccc058dbf229cadf4148ca05248b"
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
