class Cozy < Formula
  desc "A Comfort First terminal editor and pager: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.37/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "d50588bf71587bc48bb6918cf309f5227a1ff5c0cd025e7a79bb31ee995eadfa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.37/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "02557dfbac110b4e88b9130681187827bd6863325e9904fe68765d673678a3c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.37/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f43891d71c8948a43dead5ed90c0835fe0889842788d3bf606c69c43a8f7903b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.37/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a921572d037a6d55be821a360902231cd65b0c7ae9db3567200c4ca59aed5d97"
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
      bin.install "cozy", "czv"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cozy", "czv"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cozy", "czv"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cozy", "czv"
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
