module FactoryFaster
  class Target

    attr_accessor :line_number, :passed, :skip

    def initialize(line_number, skip=false)
      @line_number = line_number
      @passed = false
      @skip = skip
    end

    def skip?
      skip
    end

    def passed?
      passed
    end

  end

end
