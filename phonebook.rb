require 'json'

class Phonebook
  attr_accessor :filename, :content, :params

  def initialize(params)
    params.each_with_index do |e, i|
      if e == "-b"
        @filename = "phonebooks/" + params[i+1] += ".pb"
        params.delete_at(i)
        params.delete_at(i)
      else
        e
      end
    end
    @filename ||= "phonebooks/" + params[0] + ".pb"
    @params = params
    open if phonebook?
  end

  def create
    if !phonebook?
      File.open(@filename, 'w') {|file| file.write("{}") }
      puts "New phonebook \"#{@filename}\" created"
    else
      puts "File already exists!"
    end
    open
  end

  def phonebook?
    File.exists? @filename
  end

  def open
    if phonebook?
      @content ||= JSON.parse(File.read @filename)
    else
      puts "This phonebook does not exist!"
      exit
    end
  end

  def add
    if content[@params[0]]
      puts "There is already an entry for that name!"
    else
      @content[@params[0]] = @params[1]
      save
    end
  end

  def change
    if content[@params[0]]
      @content.delete( @params[0] )
      save
    else
      puts "There is no entry for that name!"
    end
  end

  def remove
    if content[@params[0]]
      @content[@params[0]] = @params[1]
      save
    else
      puts "There is no entry for that name!"
    end
  end

  def lookup
    wins = @content.select {|k, v| k.include? @params[0] }
    if wins != {}
      wins.each { |k, v| print k + " : " + v + "\n" }
    else
      puts "There is no entry for that name!"
    end
  end

  def reverse_lookup
    wins = @content.invert.select {|k, v| k.include? @params[0] }
    if wins != {}
      wins.each { |k, v| print k + " : " + v + "\n" }
    else
      puts "There is no entry for that number!"
    end
  end

  def save
    File.open(filename, "w") do |f|
      f.write(@content.to_json)
    end
  end

end
