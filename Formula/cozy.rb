class Cozy < Formula
  desc "A Comfort First terminal text editor: type like nano, navigate like vim"
  homepage "https://labs.navii.online/"
  version "0.2.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.22/cozy-aarch64-apple-darwin.tar.gz"
      sha256 "b2fcbd406992f593095e30977a3fbdd0163b32b0993378430d039160ef1d5ea1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.22/cozy-x86_64-apple-darwin.tar.gz"
      sha256 "d6bd778b6a7205a3afd87a9270fa96d6aa9fef4b045bdd95acc07c7edfe93a05"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.22/cozy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8cf4b0c3fbaf5096cd2ac73317f6b9e5cfa3a96987c000b2fffb6153fd244701"
    end
    if Hardware::CPU.intel?
      url "https://github.com/takakix2/cozy/releases/download/v0.2.22/cozy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b10801c64428453375033b6bb3125ff892fec05bf934273bb219cfeb1841dc7"
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
