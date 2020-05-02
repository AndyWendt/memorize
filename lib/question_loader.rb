require 'yaml'
require 'pathname'

class QuestionLoader
  def retrieve(filepath)
    if ::File.directory?(filepath)
      read_directory(filepath)
    else
      read_file(filepath)
    end
  end

  private

  def read_file(filepath)
    begin
      YAML.load(::File.read(filepath)) || []
    rescue
      raise "Invalid file #{filepath}"
    end
  end

  def read_directory(path)
    yamls = []
    Dir["#{path}/*.yml"].each do |file|
      yamls.concat(read_file(file))
    end

    yamls
  end
end
