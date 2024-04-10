class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.8.tar.gz"
  sha256 "0584083b1e65b4b8923f535d72e21654710f030ee866b15c8d9698ef5743cb08"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.8"
    sha256 cellar: :any,                 monterey:     "228ab8e1220d6d39f37095309ac20e87e611e413e39abb73bb50126f991f92c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec551a97d92b3882b80238b8681fa3cb0af0c17267916c040f8070a7edeedd36"
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
