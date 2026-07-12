class Lynkr < Formula
  desc "Self-hosted LLM gateway and tier-routing proxy for AI coding tools"
  homepage "https://github.com/Fast-Editor/Lynkr"
  url "https://registry.npmjs.org/lynkr/-/lynkr-9.8.0.tgz"
  sha256 "c24b3cda0a69c645a4f21b8c809611f8c3631061f7fa3e203e1f61f2acae7885"
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
