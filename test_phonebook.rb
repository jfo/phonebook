require "test/unit"
require_relative "phonebook.rb"

class PBTest < Test::Unit::TestCase

  def setup
    @testpb = Phonebook.new(['testerpb'])
    @testpb.create
    @testpb.open
  end

  def test_create
    assert File.exist?("phonebooks/testerpb.pb")
  end

  def test_open
    assert @testpb.content != nil
  end

  def test_add
    @testpb.params = ["john", "555-5555"]
    @testpb.add
    assert_equal @testpb.content, {"john" => "555-5555"}
  end

  def test_change
    @testpb.params = ["john", "666-6666"]
    @testpb.add
    assert_equal @testpb.content, {"john" => "666-6666"}
  end

  def test_remove
    @testpb.params = ["john"]
    @testpb.remove
    assert_equal @testpb.content, {}
  end

  def test_lookup

    @testpb.params = ["Bob", "777-7777"]
    @testpb.add
    @testpb.params = ["Bob"]

    $stdout = File.open("test.log", "w")
    @testpb.lookup
    $stdout.close
    $stdout = STDOUT

    assert_equal "Bob : 777-7777\n", File.open("test.log").read
    File.delete "test.log"

  end

  def test_reverse_lookup

    @testpb.params = ["Bob", "777-7777"]
    @testpb.add
    @testpb.params = ["777-7777"]

    $stdout = File.open("test.log", "w")
    @testpb.reverse_lookup
    $stdout.close
    $stdout = STDOUT

    assert_equal "777-7777 : Bob\n", File.open("test.log").read
    File.delete "test.log"

  end

  def teardown
    File.delete "phonebooks/testerpb.pb"
  end

end

