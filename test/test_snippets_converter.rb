require 'test_helper'

class TestSnippetsConverter < Test::Unit::TestCase

  def setup
    @snippets = []
    @snippets << [ "${1: ${2: cool} }", " ${2: cool} "]
    @snippets << [ "${1: cool $2 }", " cool $2 "]
    @snippets << [ "${1: ${2: $cool} }", " ${2: $cool} "]
    @snippets << [ "${1: [ ${2: cool} ] }", " [ ${2: cool} ] "]
    @snippets << [ "${1: ${2: cool} ${3: guy} }", " ${2: cool} ${3: guy} "]
    @snippets << [ "${1: [ ${2: cool} ${3: guy} ] }", " [ ${2: cool} ${3: guy} ] "]
    @snippets << [ "${1: [ ${2: cool} ${3: guy ${4:tralala}} ] }", " [ ${2: cool}  guy ${4:tralala} ] "]
    @snippets << [ "${1: [ ${2: cool} ${3: guy { ${4:tralala} } } ] }", " [ ${2: cool}  guy { ${4:tralala} }  ] "]
    @snippets << [ 'should_have_db_column :${1:name}${2:, :${3:type} =&gt; ${4:"${5:string}"}${6:, :${7:default} =&gt; ${8:nil}}}', 'should_have_db_column :${1:name}, :${3:type} =&gt; "${5:string}", :${7:default} =&gt; ${8:nil}']
    @snippets << [ "should_have_db_indices :${1:object_id}${2:, [:${3:commentable_type}, :${4:commentable_id}]}$0", "should_have_db_indices :${1:object_id}, [:${3:commentable_type}, :${4:commentable_id}]$0" ]

    snippet = 'context "${1:description}" do
  ${2:setup do
    ${3: cool}
  end

  }should "${4:description}" do
    ${5: guy}
  end
end'

    expected_snippet = 'context "${1:description}" do
  setup do
    ${3: cool}
  end

  should "${4:description}" do
    ${5: guy}
  end
end'

    @snippets << [ snippet, expected_snippet ]
    @snippets << [ "[ ${3::${4:key} =&gt; ${5:value}${6:, :${7:key} =&gt; ${8:value} }  } ]", "[ :${4:key} =&gt; ${5:value}, :${7:key} =&gt; ${8:value}    ]" ]
    @snippets << [ " { ${3::${4:key} =&gt; ${5:value}${6:, :${7:key} =&gt; ${8:value}}} } ", " { :${4:key} =&gt; ${5:value}, :${7:key} =&gt; ${8:value} } " ]

    snippet = 'context "on POST to :${1:create}" do
  setup do
    post :$1, :${2:user} =&gt; { ${3::${4:key} =&gt; ${5:value}${6:, :${7:key} =&gt; ${8:value} } } }
  end

  ${9:should "${10:description}" do
    $0
  end}
end'

    expected_snippet = 'context "on POST to :${1:create}" do
  setup do
    post :$1, :${2:user} =&gt; { :${4:key} =&gt; ${5:value}, :${7:key} =&gt; ${8:value}   }
  end

  should "${10:description}" do
    $0
  end
end'
    @snippets << [ snippet, expected_snippet ]

    snippet = 'context "${1:description}" do
  ${2:setup do
    $3
  end

  }should "${4:description}" do
    $0
  end
end'

    expected_snippet = 'context "${1:description}" do
  setup do
    $3
  end

  should "${4:description}" do
    $0
  end
end'
    @snippets << [ snippet, expected_snippet ]
  end


  def test_snippets_conversion
    @snippets.each do |snippet, expected_snippet|
      SnippetsConverter::Base.new.transform_snippet(snippet)
      assert_equal expected_snippet, snippet
    end

  end

end

