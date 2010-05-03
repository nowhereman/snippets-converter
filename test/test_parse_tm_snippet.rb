require 'test_helper'
require 'nokogiri'

class TestParseTmSnippet < Test::Unit::TestCase

  def setup
    tm_snippet = SnippetsConverter.new.parse_tm_snippet(File.dirname(__FILE__) + '/examples/assert_bad_value.tmSnippet')
    
    @trigger = tm_snippet[:trigger]
    @code = tm_snippet[:code]
    @description = tm_snippet[:description]
    @language = tm_snippet[:language]
  end


  def test_snippet_parsing
    assert 'asbv', @trigger
    assert 'assert_bad_value(${1:${2:Model}}, :${3:attribute}, ${4:value}${5:, /${6:message_to_expect}/})', @code
    assert 'assert_bad_value', @description
    assert 'source.ruby.rails.shoulda', @language
  end

end
