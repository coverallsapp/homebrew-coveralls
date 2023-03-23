class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.2.17.tar.gz"
  sha256 "2918b03804b6161d604b321586419d47b7347343cd5146a05cfa45e7024abc5c"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.2.16"
    sha256 cellar: :any,                 monterey:     "6d3d8acf713adc265044e7eef9f56ba31206522ca63d588c062a7a472631aed0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f8eec1e67aae3caeabf39db2b66480524dae430a4381dcc38524e1bb434954d"
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
