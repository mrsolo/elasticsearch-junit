require 'find'
require 'nokogiri'
require 'active_support/core_ext/hash/conversions'


class Processor
  def Processor.find(top_level = ENV['PWD'])
    results = []
    Find.find(top_level) do |path|
      #skip directory
      unless(File.directory?(path))
        #check to see if has '.xml' extension
        if(File.extname(path) == '.xml')
          if block_given?
            yield path
          else
            results.push(path)
          end
        end
      end
    end
    results
  end  

  def Processor.parse(file_name)
    doc = nil
    File.open(file_name) do |f|
      doc = Hash.from_xml(Nokogiri::XML(f).to_s)
      if block_given?
        yield doc
      end
    end
    return doc
  end
end 
