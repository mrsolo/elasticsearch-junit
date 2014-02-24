require 'find'

class Processor
  def Processor.find(top_level = ENV['PWD'])
    Find.find(top_level) do |path|
      #skip directory
      unless(File.directory?(path))
        #check to see if has '.xml' extension
        if(File.extname(path) == '.xml')
          puts File.basename(path)
        end
      end
    end
  end  
end 
