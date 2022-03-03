#! /usr/bin/env ruby

require 'optparse'
require 'asciidoctor'

if ARGV.length < 2
	STDERR.puts "First parameter is path/name of main AsciiDoc file."
	STDERR.puts "Second parameter is path/name of file containing attributes listing."
	exit 1
end
 
asciidoc_file = ARGV[0]
if $DEBUG
	STDERR.puts "Collecting include:: files from '#{asciidoc_file}'"
end

attr_file = ARGV[1]
if $DEBUG
	STDERR.puts "Based upon attributes from '#{attr_file}'"
end
 
af = open attr_file
attr_content = af.read.delete("\n")
af.close
 
cmd = ""
cmd.concat(" Asciidoctor.load_file '")
cmd.concat("#{asciidoc_file}', ")
cmd.concat("safe: :safe , attributes: [")
cmd.concat("#{attr_content}]")
if $DEBUG
	STDERR.puts "Command arguments", cmd
end

doc = eval(cmd)
puts "#{doc.catalog[:includes].keys.join("\n")}"
