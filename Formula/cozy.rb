class Cozy < Formula
  desc "A Comfort First terminal text editor: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.32"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.32/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "4cf1322625ef5442305b13da3c79029bac94e966fa832be9bc56fd184cd1bff2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.32/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "ac54e2c6aa909ccc51d8b93800ef63daf3ce19a6025b687aff2903fa81d3d656"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.32/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4859a952df1395ec21c28ebbc1f0468095df9155c1d96f0066580ff5e5704cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.32/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b6ae08376f9a63b09999a814fc3356742bfae76782b8f64114a91a9329cd477"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cozy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cozy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cozy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cozy"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
