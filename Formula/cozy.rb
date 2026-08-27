class Cozy < Formula
  desc "A Comfort First terminal text editor: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.29"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.29/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "ce78adeca4d6512a9922a81c76ef3e48f1e8e914abb7aac83262bf003e582395"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.29/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "12b68e77452769ba02380feef98898b633825d1f8d192ee37198f0680fa1bd69"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.29/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a066662594674fde9f254996ac2b532fc762f136509b62da20c393e33e7c840f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.29/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "000a590ecb60383e829d253d9484e397d30d6e76a1fe7541d19dee9056af9785"
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
