#!/usr/bin/ruby -w

require "rdoc/ri/driver"
require "shellwords"

ri     = RDoc::RI::Driver.new
# $stderr.puts ARGV.inspect
search = Shellwords.split(ARGV.first || ENV['COMP_LINE']).last
found  = []

def d x
  # $stderr.puts x.inspect
end

d :env => ENV["COMP_LINE"]
d :argv => ARGV
d :search => search

if search =~ /^[A-Z]/ then
  if search =~ /[#.]/ then
    found += ri.list_methods_matching(search)
  else
    found += ri.classes.keys.grep(/#{search}/)
    # found += ri.classes.keys.grep(/#{search}/).flat_map { |k| ri.list_methods_matching k }
  end
else
  found += ri.list_methods_matching(search)
end

d :found1 => found

found.map! { |s| s[/#{search}.*/] }

d :found2 => found

puts found.sort.uniq
