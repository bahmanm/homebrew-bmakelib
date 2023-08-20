# frozen_string_literal: true

class Bmakelib < Formula
  desc "It is a minimalist standard library for writing Makefiles"
  homepage "https://github.com/bahmanm/bmakelib"
  url "https://github.com/bahmanm/bmakelib/releases/download/v0.4.1/bmakelib-0.4.1.tar.gz"
  sha256 "d60a6b0674941bee801571677fa3d6e09f9d85835ec9f790b5f040feed0eada6"
  license "Apache-2.0"

  depends_on "bash" => [:build, :test]
  depends_on "make" => [:build, :test]
  depends_on "perl" => [:build, :test]

  depends_on "bash"
  depends_on "make"
  depends_on "perl"

  def install
    ENV["PATH"] = "#{prefix}/opt/make/libexec/gnubin:" + ENV["PATH"]
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
      ENV["PATH"] = "#{prefix}/opt/make/libexec/gnubin:" + ENV["PATH"]
      assert_equal "0.4.1", shell_output("make -I ${HOMEBREW_PREFIX}/include echo-version").strip
    end
  end
end
