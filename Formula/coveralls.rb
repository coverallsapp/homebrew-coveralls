class Coveralls < Formula
  desc "Self-contained, universal coverage uploader for Coveralls"
  homepage "https://github.com/coverallsapp/coverage-reporter"
  url "https://github.com/coverallsapp/coverage-reporter/archive/refs/tags/v0.6.16.tar.gz"
  sha256 "2c2c69a758a5a02c9897fad1a43614657db546289632bc76e2bbcba03472ee89"
  license "MIT"

  bottle do
    root_url "https://github.com/coverallsapp/homebrew-coveralls/releases/download/coveralls-0.6.16"
    sha256 cellar: :any,                 arm64_sequoia: "810b1ac343f38db2935b84277c9f88d63aad44a030e5fe1171083c120bf2217d"
    sha256 cellar: :any,                 arm64_sonoma:  "920b3e323ccd11e3ebd00f2872bd5c041afb70e7b7310edb6d740ea33340f72b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e42188dd5ab22f0235564aec287ec2f852cf1bdcc8ddba56de614725563eb272"
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "libyaml"
  depends_on "pcre2"
  depends_on "sqlite"

  # uses_from_macos "libxml2"
  # Force brewed libxml2 (system libxml2 crashes on macOS 15.4+)
  depends_on "libxml2"

  def install
    # Ensure the build links against brewed libxml2
    ENV.append_path "PKG_CONFIG_PATH", Formula["libxml2"].opt_lib/"pkgconfig"
    ENV.prepend     "LDFLAGS",  "-L#{Formula["libxml2"].opt_lib}"
    ENV.prepend     "CPPFLAGS", "-I#{Formula["libxml2"].opt_include}"

    system "shards", "build", "coveralls", "--production", "--release", "--no-debug"
    system "strip", "./bin/coveralls"
    bin.install "./bin/coveralls"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/coveralls --version").chomp
  end
end
