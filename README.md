# FactoryFaster

FactoryFaster optimizes your Rails app's FactoryGirl usage by replacing `create` with `build` where it's safe to do so.

## Installation

Add this line to your application's `Gemfile` in the 'development' group:

    gem 'factory_faster'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_faster

## Usage

Process just one file with:

    bundle exec script/rails runner "FactoryFaster::Batch.new('test/unit/foo_test.rb').process"

Or if you want to include the gem but not `require` it in your `Gemfile`:

    bundle exec script/rails runner "require 'factory_faster' ; FactoryFaster::Batch.new('test/unit/foo_test.rb').process"

Or use a glob to process lots of files:

    bundle exec script/rails runner "FactoryFaster::Batch.new('test/unit/*.rb').process"

The output will be something like this:

    foo> $ bundle exec script/rails runner "FactoryFaster::Batch.new('test/unit/foo_test.rb').process"
    Processing test/unit/foo_test.rb
    Checking target 1 of 2 on line 42
    Replacing create with build
    Running test
    Passed!
    Checking target 2 of 2 on line 207
    Replacing create with build
    Running test
    Passed!
    2 of 2 could be replaced, so replacing those

## BUGS / TODO

Adding a new test to a file invalidates all the skip line numbers after the addition.  Subsequent runs then get both the old and the new line numbers, so gradually more and more lines get skipped.

FactoryFaster will miss the case there a test case has multiple calls to `Factory.create` and if more than one of then has to be switched to `Factory.build` in order to trigger an error.

FactoryFaster depends on `sed` to replace the code.  It could use plain old Ruby instead.

FactoryFaster doesn't skip commented out lines.
## Contributing

1. Fork it ( http://github.com/<my-github-username>/factory_faster/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contributors

Tom Copeland - author
Ronnie Miller - method name bugfix