require 'question_loader'

RSpec.describe QuestionLoader do
  it "loads yaml from a file" do
    filepath = "#{Dir.getwd}/spec/support/yaml_files/foo.yml"
    contents = QuestionLoader.new.retrieve(filepath)
    expect(contents[0]["foo"]).to eq(true)
  end

  it "loads a directory of yaml files" do
    filepath = "#{Dir.getwd}/spec/support/yaml_files"
    contents = QuestionLoader.new.retrieve(filepath)
    expect(contents.length).to eq(2)
    expect(contents).to include("foo" => true)
    expect(contents).to include("baz" => true)
  end
end
