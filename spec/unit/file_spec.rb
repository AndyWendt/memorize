require 'memorize/commands/file'

RSpec.describe Memorize::Commands::File do
  it "executes `file` command successfully" do
    output = StringIO.new
    options = {}
    command = Memorize::Commands::File.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
