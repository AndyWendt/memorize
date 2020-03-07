require 'definition_loader'

RSpec.describe DefinitionLoader do
  it "loads yaml from a file" do
    filepath = "#{Dir.getwd}/spec/support/yaml_files/foo.yml"
    contents = DefinitionLoader.new.read_file(filepath)
    expect(contents[0]["foo"]).to eq(true)
  end

  it "loads a directory of yaml files" do
    filepath = "#{Dir.getwd}/spec/support/yaml_files"
    contents = DefinitionLoader.new.read_directory(filepath)
    expect(contents.length).to eq(2)
    expect(contents).to include("foo" => true)
    expect(contents).to include("baz" => true)
  end
end
