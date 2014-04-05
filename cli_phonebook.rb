#!/usr/bin/env ruby

require_relative 'phonebook.rb'

command = ARGV.shift.to_sym
Phonebook.new(ARGV).send(command)
