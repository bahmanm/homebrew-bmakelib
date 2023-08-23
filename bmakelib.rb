# frozen_string_literal: true

class Bmakelib < Formula
  desc "It is a minimalist standard library for writing Makefiles"
  homepage "https://github.com/bahmanm/bmakelib"
  url "https://github.com/bahmanm/bmakelib/releases/download/v0.4.4/bmakelib-0.4.4.tar.gz"
  sha256 "743d166e27753d4d40cb1cd6388bd39b1902c235acbd22f3a7c6f3123fa065cd"
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
          "include bmakelib/bmakelib.mk",
          "PHONY:echo-version",
          "echo-version:",
          "\t@echo $(bmakelib.VERSION)",
        ].join("\n"),
      )
      ENV["PATH"] = "#{ENV["HOMEBREW_PREFIX"]}/opt/make/libexec/gnubin:#{ENV["PATH"]}"
      assert_match(/^Gnu Make 4\.4\.1.*+/, shell_output("make -I #{include} echo-version").strip)
      assert_equal("0.4.4", shell_output("make -I #{include} echo-version").strip)
    end
  end
end
