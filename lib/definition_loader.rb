require 'yaml'

class DefinitionLoader
  def read_file(filepath)
    YAML.load(::File.read(filepath))
  end

  def read_directory(path)
    yamls = []
    Dir["#{path}/*.yml"].each do |file|
      yamls.concat(read_file(file))
    end

    yamls
  end
end
