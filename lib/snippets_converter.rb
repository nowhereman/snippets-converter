class SnippetsConverter
  require 'rubygems'
  require 'active_support'
  require 'nokogiri'

  Dir[File.dirname(__FILE__) + '/snippets_converter/editors/*.rb'].each do |file| 
    require file
  end

  def initialize    
  end
  
  def convert(file)
    xml = File.read(file)
    doc = Nokogiri::XML(xml)
    i = 0
    j = 0

    arrKey = Array.new
    arrString = Array.new
    # Transform the key and string node into arrays
    doc.xpath('//key','//string').each do |key|
      if key.name == "key"
        arrKey[i] = key.text
        i+=1
      else
        arrString[j] = key.text
        j+=1
      end
    end

    code = arrString[arrKey.index('content')]
    transform_snippet(code)
    return editor_conversion(arrString[arrKey.index('tabTrigger')], arrString[arrKey.index('name')], code)

  end

  # Nested tab stops and place holders remover, e.g '${1: ${3:cool} $2 }' become ' ${3:cool} $2 '
  def transform_snippet(code)
      
    # Nested tab stops, e.g '${1: $2 }'
    nested_tab_stop = /((\$\{[0-9]{1,5}:[^${}]*)\$([0-9]{1,5})([^${}]*\}))+/m
    code.gsub!(nested_tab_stop, '\2:nested_tab_stop\3:\4')

    code.gsub!(/\$([0-9]{1,5})/, ':tab_stop\1:') # Tab Stop, e.g '$0'
    code.gsub!(/\$([^{][^0-9]+[^:])/, ':dollar:\1') # Dollar, e.g. '$titi'
    
    # Place holders, e.g. '${1: cool }'
    place_holders = /\$\{((?>[^${}]+)|(\1))+\}/m
    place_holders_matches = code.scan(place_holders)
    place_holders_matches.flatten.each do |place_holder|
      if place_holder
        idx = place_holder.gsub(/([0-9]{1,5}):.+/,'\1')
        code.gsub!(/\$\{#{place_holder}\}/m, ":place_holders#{idx}:")
      end
    end

    # Nested place holders, e.g. '${1: ${3:cool} }'
    nested_place_holders = /(\$\{[0-9]{1,5}:(([^${}]*(\$\{[0-9]{1,5}:|\{)[^${}]+\}[^${}]*)|[^${}]+)\})/m
    i = 0
    loop do
      i += 1
      break if !code.gsub!(nested_place_holders, '\2') || i > 20
    end

    place_holders_matches.flatten.each do |place_holder|
      if place_holder
        idx = place_holder.gsub(/([0-9]{1,5}):.+/,'\1')
        code.gsub!(/:place_holders#{idx}:/m, "\$\{#{place_holder}\}")
      end
    end

    # Nested tab stops
    code.gsub!(/:nested_tab_stop([0-9]{1,5}):/, '$\1')
    nested_tab_stop = /(\$\{[0-9]{1,5}:([^${}]*\$[0-9]{1,5}[^${}]*)\})+/m
    i = 0
    loop do
      i += 1
      break if !code.gsub!(nested_tab_stop, '\2') || i > 20
    end     

    code.gsub!(/:tab_stop([0-9]{1,5}):/, '$\1')
    code.gsub!(/:dollar:/, '$')
  end

  # Dummy methods, the current Editor module must override them
    def editor_conversion(trigger, description, code)
      raise Exception.new("The current Editor module must implement this method")
    end

    def editor_header
      raise Exception.new("The current Editor module must implement this method")
    end

    def editor_bottom
      raise Exception.new("The current Editor module must implement this method")
    end

    def editor_target_file
      raise Exception.new("The current Editor module must implement this method")
    end

  def run(*args)
    @in_folder = Dir.pwd # File.dirname(__FILE__) + '/../in'
    @out_folder = Dir.pwd + '/out' # File.dirname(__FILE__) + '/../out'

    @editor = args.first || 'Netbeans' # default editor is NetBeans
    @editor = 'Netbeans' if @editor == 'NetBeans' # Dirty fix for NetBeans editor name
    extend "SnippetsConverter::Editors::#{@editor.camelize}".constantize

    raise Exception.new("You must have a '#{@in_folder}' folder writable") if !File.directory?(@in_folder) || !File.writable?(@in_folder) 
    raise Exception.new("You must have a '#{@out_folder}' folder writable") if !File.directory?(@out_folder) || !File.writable?(@out_folder) 
    
    output = editor_header
    for file in Dir.glob("#{@in_folder}/**/*.tmSnippet")
      puts "Converting #{file} to #{@editor} snippet..."
      output = "#{output}#{convert(file)}"
    end
    output = "#{output}#{editor_bottom}"
    
    File.open("#{@out_folder}/#{editor_target_file}", "w") do |f|
      f.write(output)
    end

    puts "Result stored in '#{Pathname.new(@out_folder).realpath.to_s}/#{editor_target_file}'"
    puts "**** Done ****"
  end
  
end

