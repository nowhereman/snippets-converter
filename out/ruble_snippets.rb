  require 'ruble'

  with_defaults :scope => "[LANGUAGE]" do |bundle|

    snippet "should_belong_to" do |snippet|
      snippet.trigger = "shbt"
      snippet.expansion = "should_belong_to :${1:object}"
    end

    snippet "should_have_db_indices" do |snippet|
      snippet.trigger = "shhdi"
      snippet.expansion = "should_have_db_indices :${1:column}, :${3:column}, :${5:column}"
    end

    snippet "should_have_and_belong_to_many" do |snippet|
      snippet.trigger = "shhabtm"
      snippet.expansion = "should_have_and_belong_to_many :${1:object}, :${3:object}, :${5:object}"
    end

    snippet "should_return_from_session" do |snippet|
      snippet.trigger = "shrfs"
      snippet.expansion = "should_return_from_session :${1:user}, \"@${1:user}\""
    end

    snippet "assert_does_not_contain" do |snippet|
      snippet.trigger = "asdnc"
      snippet.expansion = "assert_does_not_contain(${1:collection}, /${3:x}/, \"${5:extra_msg}\")"
    end

    snippet "should_render_with_layout" do |snippet|
      snippet.trigger = "shrl"
      snippet.expansion = "should_render_with_layout '${2:layout}'"
    end

    snippet "Factory.define with class" do |snippet|
      snippet.trigger = "facd"
      snippet.expansion = "Factory.define :${1:model}, :class => ${3:ClassName} do |f|
  f.$0
end"
    end

    snippet "assert_save" do |snippet|
      snippet.trigger = "assave"
      snippet.expansion = "assert_save ${1:object}	"
    end

    snippet "should_have_readonly_attributes" do |snippet|
      snippet.trigger = "shhra"
      snippet.expansion = "should_have_readonly_attributes :${1:method}, :${3:method}, :${5:method}"
    end

    snippet "should_change from to" do |snippet|
      snippet.trigger = "shc"
      snippet.expansion = "should_change(\"${1:description}\", :from => \"${5:old_value}\", :to => \"${8:new_value}\") { ${10:Model}.${11:count} }$0"
    end

    snippet "should_allow_mass_assignment_of" do |snippet|
      snippet.trigger = "shamao"
      snippet.expansion = "should_allow_mass_assignment_of :${1:attribute}, :${3:attribute}, :${5:attribute}"
    end

    snippet "should_render_a_form" do |snippet|
      snippet.trigger = "shraf"
      snippet.expansion = "should_render_a_form"
    end

    snippet "should_change by" do |snippet|
      snippet.trigger = "shc"
      snippet.expansion = "should_change(\"${1:description}\", :by => \"${4:value}\") { ${6:Model}.${7:count} }$0"
    end

    snippet "should block" do |snippet|
      snippet.trigger = "sh"
      snippet.expansion = "should \"$1\" do
  $0
end"
    end

    snippet "should_have_db_index" do |snippet|
      snippet.trigger = "shhdi"
      snippet.expansion = "should_have_db_index :${1:column}"
    end

    snippet "should_not_allow_mass_assignment_of" do |snippet|
      snippet.trigger = "shnamao"
      snippet.expansion = "should_not_allow_mass_assignment_of :${1:attribute}, :${3:attribute}, :${5:attribute}"
    end

    snippet "should_have_class_methods" do |snippet|
      snippet.trigger = "shhcm"
      snippet.expansion = "should_have_class_methods :${1:method}, :${3:method}, :${5:method}"
    end

    snippet "should_respond_with" do |snippet|
      snippet.trigger = "shrw"
      snippet.expansion = "should_respond_with :${1:success}$0"
    end

    snippet "should_set_the_flash_to" do |snippet|
      snippet.trigger = "shsf"
      snippet.expansion = "should_set_the_flash_to ${1:value}"
    end

    snippet "should_eventually" do |snippet|
      snippet.trigger = "she"
      snippet.expansion = "should_eventually \"$1\" do
  $0
end"
    end

    snippet "should_not_set_the_flash" do |snippet|
      snippet.trigger = "shnsf"
      snippet.expansion = "should_not_set_the_flash"
    end

    snippet "should_not_change" do |snippet|
      snippet.trigger = "shnc"
      snippet.expansion = "should_not_change(\"${1:description}\") { ${2:Model}.${3:count} }$0"
    end

    snippet "Factory.sequence" do |snippet|
      snippet.trigger = "facs"
      snippet.expansion = "Factory.sequence :${1:name} do |n|
  $0
end"
    end

    snippet "should_have_many" do |snippet|
      snippet.trigger = "shhm"
      snippet.expansion = "should_have_many :${1:objects}, :through => :${4:association}, :dependent => :${6:destroy}$0"
    end

    snippet "should_not_assign_to" do |snippet|
      snippet.trigger = "shna"
      snippet.expansion = "should_not_assign_to :${1:name}, :${3:name}, :${5:name}"
    end

    snippet "should_validate_numericality_of" do |snippet|
      snippet.trigger = "shvno"
      snippet.expansion = "should_validate_numericality_of :${1:attribute}"
    end

    snippet "should_ensure_length_in_range" do |snippet|
      snippet.trigger = "shel"
      snippet.expansion = "should_ensure_length_in_range :${1:attribute}, (${2:range})"
    end

    snippet "should_restfully_route" do |snippet|
      snippet.trigger = "shrr"
      snippet.expansion = "context \"when routing\" do
  should_route :get,    \"/${1:brands}\",        :controller => :$1, :action => :index
  should_route :get,    \"/$1/1\",      :controller => :$1, :action => :show,    :id => 1
  should_route :get,    \"/$1/1/edit\", :controller => :$1, :action => :edit,    :id => 1
  should_route :get,    \"/$1/new\",    :controller => :$1, :action => :new
  should_route :post,   \"/$1\",        :controller => :$1, :action => :create
  should_route :put,    \"/$1/1\",      :controller => :$1, :action => :update,  :id => 1
  should_route :delete, \"/$1/1\",      :controller => :$1, :action => :destroy, :id => 1
end$0"
    end

    snippet "should_render_without_layout" do |snippet|
      snippet.trigger = "shrl"
      snippet.expansion = "should_render_without_layout"
    end

    snippet "assert_same_elements" do |snippet|
      snippet.trigger = "asse"
      snippet.expansion = "assert_same_elements(${1:array1}, ${2:array2}, \"${4:message}\")"
    end

    snippet "assert_sent_email" do |snippet|
      snippet.trigger = "assemail"
      snippet.expansion = "assert_sent_email do |email|
  email.${2:subject|from|to|body}|${2:subject|from|to|body}|${2:subject|from|to|body}|${2:subject|from|to|body} ${3:==} '${5:anything}':tab_s${2:subject|from|to|body}p0:
end"
    end

    snippet "should_not_allow_values_for" do |snippet|
      snippet.trigger = "shnav"
      snippet.expansion = "should_not_allow_values_for :${1:attribute}, \"$2\", \"$4\", \"$6\""
    end

    snippet "assert_bad_value" do |snippet|
      snippet.trigger = "asbv"
      snippet.expansion = "assert_bad_value(${2:Model}, :${3:attribute}, ${4:value}, /${6:message_to_expect}/)"
    end

    snippet "should_render_template" do |snippet|
      snippet.trigger = "shrt"
      snippet.expansion = "should_render_template :${1:template}"
    end

    snippet "Factory attributes for" do |snippet|
      snippet.trigger = "faca"
      snippet.expansion = "Factory.attributes_for(:${1:model})"
    end

    snippet "should block with before proc" do |snippet|
      snippet.trigger = "shb"
      snippet.expansion = "should \"$1\", :before => lambda { ${3:any_code} \} do
  $0
end"
    end

    snippet "should_allow_values_for" do |snippet|
      snippet.trigger = "shav"
      snippet.expansion = "should_allow_values_for :${1:attribute}, \"$2\", \"$4\", \"$6\""
    end

    snippet "attribute" do |snippet|
      snippet.trigger = "f."
      snippet.expansion = "f.${1:attribute} '${3:value}'
f.$0"
    end

    snippet "should_create" do |snippet|
      snippet.trigger = "shcre"
      snippet.expansion = "should_create :${1:model}$0"
    end

    snippet "should_have_instance_methods" do |snippet|
      snippet.trigger = "shhim"
      snippet.expansion = "should_have_instance_methods :${1:method}, :${3:method}, :${5:method}"
    end

    snippet "context block with setup" do |snippet|
      snippet.trigger = "cont"
      snippet.expansion = "context \"${1:description}\" do
  setup do
    $3
  end

  should \"${4:description}\" do
    $0
  end
end
"
    end

    snippet "Factory" do |snippet|
      snippet.trigger = "fac"
      snippet.expansion = "Factory(:${1:model})"
    end

    snippet "context block get" do |snippet|
      snippet.trigger = "contg"
      snippet.expansion = "context \"on GET to :${1:show}\" do
  setup { get :$1, :id => ${3:1} }

  should \"${5:description}\" do
    $0
  end
end"
    end

    snippet "Factory.define" do |snippet|
      snippet.trigger = "facd"
      snippet.expansion = "Factory.define :${1:model} do |f|
  f.$0
end"
    end

    snippet "association" do |snippet|
      snippet.trigger = "f.a"
      snippet.expansion = "f.association :${1:name}, :factory => :${3:factory_name}
f.$0"
    end

    snippet "should_ensure_value_in_range" do |snippet|
      snippet.trigger = "sher"
      snippet.expansion = "should_ensure_value_in_range :${1:attribute}, (${2:range})"
    end

    snippet "should_validate_acceptance_of" do |snippet|
      snippet.trigger = "shvao"
      snippet.expansion = "should_validate_acceptance_of :${1:attribute}"
    end

    snippet "should_validate_uniqueness_of with scope" do |snippet|
      snippet.trigger = "shvuo"
      snippet.expansion = "should_validate_uniqueness_of :${1:method}, :scoped_to => [:${4:column_id}, :${5:column_type}]"
    end

    snippet "should_destroy" do |snippet|
      snippet.trigger = "shde"
      snippet.expansion = "should_destroy :${1:model}$0"
    end

    snippet "should_have_one" do |snippet|
      snippet.trigger = "shho"
      snippet.expansion = "should_have_one :${1:object}, :dependent => :${3:destroy}"
    end

    snippet "should_ensure_length_is" do |snippet|
      snippet.trigger = "shel"
      snippet.expansion = "should_ensure_length_is :${1:attribute}, ${2:length}"
    end

    snippet "should_validate_presence_of" do |snippet|
      snippet.trigger = "shvpo"
      snippet.expansion = "should_validate_presence_of :${1:method}, :${3:method}, :${5:method}"
    end

    snippet "should_redirect_to" do |snippet|
      snippet.trigger = "shre"
      snippet.expansion = "should_redirect_to(\"${1:a page}\") { ${3:user}s_url(@$3) }"
    end

    snippet "context block post" do |snippet|
      snippet.trigger = "contp"
      snippet.expansion = "context \"on POST to :${1:create}\" do
  setup { post :$1, :${2:user} => { :${4:key} => ${5:value}, :${7:key} => ${8:value} } }

  should \"${10:description}\" do
    $0
  end
end
"
    end

    snippet "should_have_db_columns" do |snippet|
      snippet.trigger = "shhdc"
      snippet.expansion = "should_have_db_columns :${1:column}, :${3:column}, :${5:column}"
    end

    snippet "setup" do |snippet|
      snippet.trigger = "setup"
      snippet.expansion = "setup do
	$0
end"
    end

    snippet "assert_valid" do |snippet|
      snippet.trigger = "asv"
      snippet.expansion = "assert_valid ${1:object}"
    end

    snippet "should_have_db_column" do |snippet|
      snippet.trigger = "shhdc"
      snippet.expansion = "should_have_db_column :${1:name}, :${3:type} => \"${5:string}\", :${7:default} => ${8:nil}"
    end

    snippet "Factory build" do |snippet|
      snippet.trigger = "facb"
      snippet.expansion = "Factory.build(:${1:model})"
    end

    snippet "should_assign_to" do |snippet|
      snippet.trigger = "sha"
      snippet.expansion = "should_assign_to(:${1:name}) { @$1 \}$0"
    end

    snippet "assert_contains" do |snippet|
      snippet.trigger = "asc"
      snippet.expansion = "assert_contains(${1:collection}, /${3:x}/, \"${5:extra_msg}\")"
    end

    snippet "should_respond_with_content_type" do |snippet|
      snippet.trigger = "shrw"
      snippet.expansion = "should_respond_with_content_type :${1:rss}"
    end

    snippet "should_ensure_length_at_least" do |snippet|
      snippet.trigger = "shel"
      snippet.expansion = "should_ensure_length_at_least :${1:attribute}, ${2:min_length}"
    end

    snippet "Factory.next" do |snippet|
      snippet.trigger = "facn"
      snippet.expansion = "Factory.next(:${1:sequence})"
    end

    snippet "should_filter_params" do |snippet|
      snippet.trigger = "shfp"
      snippet.expansion = "should_filter_params :${1:key}, :${3:key}, :${5:key}"
    end

    snippet "should_route" do |snippet|
      snippet.trigger = "shr"
      snippet.expansion = "should_route :${1:get|post|put|delete}|${1:get|post|put|delete}|${1:get|post|put|delete}|${1:get|post|put|delete}, \"/${1:get|post|put|delete}s\", :controller => :$3, :action => :${7:create}, :id => ${9:1}$0"
    end

    snippet "assert_good_value" do |snippet|
      snippet.trigger = "asgv"
      snippet.expansion = "assert_good_value(${2:Model}, :${3:attribute}, ${4:value}, /${6:message_to_avoid}/)"
    end

    snippet "should_validate_uniqueness_of" do |snippet|
      snippet.trigger = "shvuo"
      snippet.expansion = "should_validate_uniqueness_of :${1:method}, :${3:method}, :${5:method}"
    end

    snippet "before_should block" do |snippet|
      snippet.trigger = "bsh"
      snippet.expansion = "before_should \"$1\" do
  $0
end"
    end

end