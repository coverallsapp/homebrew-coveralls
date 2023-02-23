class Coveralls < Formula
  desc "Self-contained, universal coverage uploader binary for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "144340394df686ce4fcce857dbfc74576aab970ea4ae59ce99bb5f6881c05046"
  license "MIT"

  depends_on "crystal" => :build
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre"

  def install
    system "shards", "install", "--production"
    system "crystal", "build", "src/cli.cr", "-o", "./dist/coveralls", "--release", "--no-debug"
    system "strip", "./dist/coveralls"
    bin.install "./dist/coveralls"
  end

  test do
    assert_match version, shell_output("#{bin}/coveralls --version")
  end
end
