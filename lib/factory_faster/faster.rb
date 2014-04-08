module FactoryFaster

  class Faster

    attr_reader :filename, :replacement_targets, :data_store

    def initialize(filename)
      @filename = filename
      data_store_file = if defined?(Rails)
        "#{Rails.root}/tmp/factory_faster.txt"
      else
        "tmp/factory_faster.txt"
      end
      @data_store = DataStore.new(data_store_file)
      @replacement_targets = load_replacement_targets
    end

    def process
      puts "Processing #{filename}"
      if data_store.unchanged?(filename)
        puts "Skipping since it hasn't changed since it was last checked"
        return
      end
      if fixable_replacement_targets.empty?
        puts "Skipping since there are no targets to fix"
        return
      end
      initial_fixable_targets_count = fixable_replacement_targets.size
      fixable_replacement_targets.select {|t| !t.skip? }.each_with_index do |target, idx|
        puts "Checking target #{idx+1} of #{initial_fixable_targets_count} on line #{target.line_number}"
        try_to_fix(target)
      end
      passed = fixable_replacement_targets.select {|t| t.passed? }
      if passed.any?
        puts "#{passed.size} of #{initial_fixable_targets_count} could be replaced, so replacing those"
        passed.each do |target|
          replace_create_with_build(target.line_number)
        end
      end
      data_store.set(filename, replacement_targets.select {|t| t.skip? }.map(&:line_number))
    end

    def try_to_fix(target)
      puts "Replacing create with build"
      replace_create_with_build(target.line_number)
      puts "Running test"
      if test_passes?
        puts "Passed!"
        target.passed = true
      else
        puts "Error, so marking as a skip"
        target.skip = true
      end
      revert_file
    end

    def revert_file
      `git checkout -- #{filename}`
    end

    def fixable_replacement_targets
      replacement_targets.select {|t| !t.skip? }
    end

    def test_passes?
      run_test
      $?.exitstatus == 0
    end

    def run_test
      cmd = "bundle exec ruby #{filename} 2>&1"
      `#{cmd}`
    end

    def replace_create_with_build(line_number)
      sed_line_number = line_number + 1
      cmd = "sed -i '' '#{sed_line_number}s/FactoryGirl.create/FactoryGirl.build/' #{filename}"
      `#{cmd}`
    end

    def load_replacement_targets
      res = []
      File.readlines(filename).each_with_index do |line, idx|
        next unless line.match /FactoryGirl.create/
        res << Target.new(idx, data_store.skips_for(filename).include?(idx))
      end
      res
    end
  end
  
end
