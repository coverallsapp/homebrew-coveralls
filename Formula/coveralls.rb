class Coveralls < Formula
  desc "Self-contained, universal coverage uploader binary for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.1.8.tar.gz"
  sha256 "a4499960c70dcb7746b45446b1ac4c15ff8cc77d576c0549969af884b27086f2"
  license "MIT"

  depends_on "crystal"
  depends_on "libyaml"

  def install
    system "shards", "install"
    system "crystal", "build", "src/cli.cr", "-o", "dist/coveralls", "--release", "--no-debug", "--progress"
    bin.install "dist/coveralls"
  end

  test do
    # assert_match version, shell_output("#{bin}/coveralls --version")
  end
end
