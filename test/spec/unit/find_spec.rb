require 'processor'

describe Processor do
  context 'when using default' do
    it "find current directory" do
       Processor.find
    end
  end
  context 'when not using default' do
  end
end
