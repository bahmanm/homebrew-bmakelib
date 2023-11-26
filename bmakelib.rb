# frozen_string_literal: true

class Bmakelib < Formula
  desc "It is a minimalist standard library for writing Makefiles"
  homepage "https://github.com/bahmanm/bmakelib"
  url "https://github.com/bahmanm/bmakelib/releases/download/v0.6.0/bmakelib-0.6.0.tar.gz"
  sha256 "ca29e4609ed77645a4553ddb94a9709990351b2593fbce0bb48901f1d60d6a4e"
  license "Apache-2.0"

  depends_on "bash" => [:build, :test]
  depends_on "make" => [:build, :test]
  depends_on "perl" => [:build, :test]

  depends_on "bash"
  depends_on "make"
  depends_on "perl"

  def install
    ENV["PATH"] = "#{ENV["HOMEBREW_PREFIX"]}/opt/make/libexec/gnubin:#{ENV["PATH"]}"
    system "echo $PATH"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    mktemp("bmakelib") do
      File.write(
        "Makefile",
        [
          "-include bmakelib/bmakelib.mk",
          "PHONY:echo-version",
          "echo-version:",
          "\t@echo $(bmakelib.VERSION)",
        ].join("\n"),
      )
      ENV["PATH"] = "#{ENV["HOMEBREW_PREFIX"]}/opt/make/libexec/gnubin:#{ENV["PATH"]}"
      assert_equal "0.6.0", shell_output("make -I #{include} echo-version").strip
    end
  end
end
