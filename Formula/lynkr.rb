class Lynkr < Formula
  desc "Self-hosted LLM gateway and tier-routing proxy for AI coding tools"
  homepage "https://github.com/Fast-Editor/Lynkr"
  url "https://registry.npmjs.org/lynkr/-/lynkr-9.5.0.tgz"
  sha256 "37134caf60e1f8a4bcf3f661b999411a37e276a51f793e1ef0d73698d85565ad"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/lynkr/latest"
    regex(/"version"\s*:\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lynkr --version")
  end
end
