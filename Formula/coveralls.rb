class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.6.tar.gz"
  sha256 "e3d70715d1b8fdc4d591ca945b80ed38397c7c0a6626e7cf75230e35ae6cf80c"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.5"
    sha256 cellar: :any,                 monterey:     "ee5b477d42fdfbdd83da6723151a99c1aade6317e0d334ad5a3a2c7bd145efb8"
    sha256 cellar: :any,                 big_sur:      "30fa7bf938070071bb196923fcb1eac8514cd9331a8640aed9bc266581113f76"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "58864bbdc1cd46655bd96ca23b40a8e19539233da9c91bcaf36a5f22df5f2059"
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
