module FactoryFaster

  #
  # Each row looks like this:
  # filename|md5 hash|lines to skip
  # test/unit/foo_test.rb|abcdefabcde|5,12,19,20
  #
  class DataStore

    attr_reader :store_file, :records

    def initialize(filename)
      @store_file = filename
      load
    end

    def set(filename, skips)
      @records[filename] = [signature_for(filename),skips]
      store
    end

    def skips_for(filename)
      (!@records[filename].nil? && !@records[filename][1].nil?) ? @records[filename][1] : []
    end

    def unchanged?(filename)
      !@records[filename].nil? && @records[filename][0] == signature_for(filename)
    end

    private

    def signature_for(filename)
      Digest::MD5::hexdigest(File.read(filename))
    end

    def store
      File.open(store_file, "w") do |f|
        @records.each do |filename, data|
          f.syswrite("#{filename}|#{data[0]}|#{data[1].join(',')}\n")
        end
      end
    end

    # in memory data structure is
    # test/unit/foo_test.rb => [abcdefabcde, [5,12,19.20]]
    def load
      @records = {}
      File.readlines(store_file).each do |line|
        fields = line.split("|")
        filename = fields[0]
        signature = fields[1]
        skips = !fields[2].nil? ? fields[2].split(',').map(&:to_i) : []
        @records[filename] = [signature, skips]
      end unless !File.exists?(store_file)
    end
  end

end
