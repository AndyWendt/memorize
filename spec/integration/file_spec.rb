RSpec.describe "`memorize file` command", type: :cli do
  it "executes `memorize help file` command successfully" do
    output = `memorize help file`
    expected_output = <<-OUT
Usage:
  memorize file

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
