module FactoryFaster
  
  class Batch

    attr_reader :glob

    def initialize(glob)
      @glob = glob
    end

    def run
      Dir.glob(glob).each do |filename|
        Faster.new(filename).process
      end
    end
    
  end

end