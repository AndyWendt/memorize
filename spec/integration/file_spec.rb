RSpec.describe "`memorize file` command", type: :cli do
  it "executes `memorize help file` command successfully" do
    output = `exe/memorize help file`
    expect(output).to include('Usage:')
  end
end
