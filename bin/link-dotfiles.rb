#!/usr/bin/env ruby
# link dotfiles into $HOME

require 'pathname'

def link(source, dest, force=false)
  if File.symlink?(dest)
    target = File.readlink(dest)
    return if target == source
    puts "removing #{dest} (symlink)"
    File.unlink(dest)
  end
  abort("error: #{dest} already exists") if File.exists?(dest)
  File.symlink(source, dest)
  puts "linked #{dest}"
end

dir = File.dirname(File.dirname(Pathname.new(__FILE__).realpath))
entries = Dir.entries(dir).reject{|e| e[0,1] == '.' || e == 'README'}
entries.each do |fn|
  source = File.join(dir, fn)
  dest = File.join(ENV['HOME'], ".#{fn}")
  link(source, dest)
end
