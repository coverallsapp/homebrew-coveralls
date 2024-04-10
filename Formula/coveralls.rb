class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.8.tar.gz"
  sha256 "0584083b1e65b4b8923f535d72e21654710f030ee866b15c8d9698ef5743cb08"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.6"
    sha256 cellar: :any,                 monterey:     "e58ffaab206fa3cd5670f6cd265c2eecb156bf95d0940975245d14c8a67943ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9731752eca26a4d1bb7a2c36f32fba814e3cbc597156685f2d0ea170e6383b4b"
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
