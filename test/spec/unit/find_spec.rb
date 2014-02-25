require 'processor'
require 'rspec/expectations'
require 'tmpdir'

describe Processor do
  context 'when using default' do
    temp_file = File.join(Dir.pwd,'temp.xml')

    it "find %s in current directory %s"%[temp_file, Dir.pwd] do
      File.open(temp_file, 'w') { |file| file.write("") }
      results = Processor.find 
      File.unlink(temp_file)
      results.should include(temp_file)
    end    
  end

  context 'when not using default' do
    test_directory = File.join(Dir.tmpdir, 'testme')
    temp_file = File.join(test_directory, 'temp.xml')

    before(:all) do
      Dir.mkdir(test_directory)
      File.open(temp_file, 'w') { |file| file.write("") }

    end

    it "find %s in %s directory"%[temp_file, test_directory] do
      results = Processor.find(test_directory)
      results.should include(temp_file)
    end      

    it "should parse junit file" do
      junit_file = File.join(Dir.pwd, 'test', 'fixtures', 'TEST-org.elasticsearch.watcher.FileWatcherTest.xml')
      doc = Processor.parse(junit_file)
      doc['testsuite']['tests'].to_i.should eq(7)
    
    end

    after(:all) do
      Dir.entries(test_directory).select { |x| x[0] != '.' }
        .map { |y| File.join(test_directory, y) }
        .each { |z| File.unlink(z) }

      Dir.rmdir(test_directory)
    end
    
  end
end
