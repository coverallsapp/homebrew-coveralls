class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "29fac6a48cffd9224b04b4d928bb6d8cfd95d41345a6746333dd028195b018b5"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.1"
    sha256 cellar: :any,                 monterey:     "9215d40bcf7b93eb177da71f82d0c3237b97001526c10ca6e7dacc96e99de59f"
    sha256 cellar: :any,                 big_sur:      "6d1a818482478644c478b316336b79ef114556815a254a9ecfe8da09937499ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1994a08b92148ff417426338b9b7c05d18241369a8ea092797e4643b36a4e09b"
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
