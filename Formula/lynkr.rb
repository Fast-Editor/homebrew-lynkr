class Lynkr < Formula
  desc "Self-hosted LLM gateway and tier-routing proxy for AI coding tools"
  homepage "https://github.com/Fast-Editor/Lynkr"
  url "https://registry.npmjs.org/lynkr/-/lynkr-9.6.0.tgz"
  sha256 "baa6b4a13d33ca97acbfd330c50ba649769cddc4888c8be55c84dc36cfcee360"
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
