class Cozy < Formula
  desc "A Comfort First terminal text editor: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.28"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.28/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "c3aa452e7eb633eeebc8e77608ed66a63c7720e339ab404470bf5951b014e154"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.28/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "7871b1bb49345bd967cca4a44a5d5ff93c43f7ba588c0144f4b09c2392d43b4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.28/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ce7cf53ded40403302b7420f2da71086d4d0a195d2cb3b7835f1640bc115e59b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.28/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9aa6eaf6cf6dc17e024aa35304029aee8e21ac4fb1502fcf8558b57b667c10cc"
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
