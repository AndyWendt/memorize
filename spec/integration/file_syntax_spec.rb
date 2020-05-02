require_relative '../../lib/question_loader'

RSpec.describe 'file syntax check' do
  it "ensures that yaml files will load" do
    result = QuestionLoader.new.retrieve('storage')
    expect(result.count).to be > 0

    dirs = Pathname.new("#{Dir.getwd}/storage").children.select { |c| c.directory? }
    dirs.each do |directory|
      result = QuestionLoader.new.retrieve(directory)
      expect(result.count).to be > 0
    end
  end
end
