class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "17f424712d9a0ebbd62ef610e6416254028a790c566f2f40e4ae374eadf88408"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.3.4"
    sha256 cellar: :any,                 monterey:     "6a4d25f50324f3d87eebe6798b6d8dd681130720a33c936a1657bf8e8cc4ccfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3314907a73223df7bf52fe575f7b75552252f5ee086ace7757179427be6c6a18"
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
