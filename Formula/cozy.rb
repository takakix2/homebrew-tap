class Cozy < Formula
  desc "A Comfort First terminal text editor: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.23"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.23/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "65b7166f2149e65f2022efbeeaccb30cff645364873cfa7501ad4bad5f27a04b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.23/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "69a50614926ae29444b66aa7ffe32fed52681398c053ff590b94fd8b885f531d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.23/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0fa5b934841aeb6b90433eddb354c4c90d8b9e227790e91e0812d51b1f9f01dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.23/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d0db295aa3a34e15a9617f45344a32ee5952ca4db77baba96d2eb8f9bc7236f8"
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
