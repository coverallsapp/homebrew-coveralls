class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.15.tar.gz"
  sha256 "b29d4b2c61ebce695c35077099da3a53b72c1280f77da4a220288ff306508e79"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.15"
    sha256 cellar: :any,                 arm64_sonoma: "56be23336cb42e70a942ad22ac37460ef8b4a96c23f6601aa5e11077e2fbd8a5"
    sha256 cellar: :any,                 ventura:      "434cdb61aa313d359fea17f320e0bac06dd36f0e9c2c7f20506bb43e90ddc2b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cfdab4396804e0c49efb370590dd0b3bb17f1a54bf8350c7dec2247673ec799e"
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
