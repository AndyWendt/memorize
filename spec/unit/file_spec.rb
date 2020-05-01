require_relative '../../lib/memorize/commands/file'

RSpec.describe Memorize::Commands::File do
  it "executes `file` command successfully" do
    output = StringIO.new
    options = {}
    command = Memorize::Commands::File.new(options, 'spec/support/empty_yaml_files/empty.yml')

    command.execute(output: output)

    expect(output.string).to eq("")
  end
end
