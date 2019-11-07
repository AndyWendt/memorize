module Quiz
  class QuizRunner
    def initialize(file)
      @file = file
    end

    def run
      puts read(@file)
    end

    private

    def read(file)
      directory ||= Dir.getwd
      File.read("#{directory}/#{file}")
    end
  end
end
