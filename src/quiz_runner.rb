module Quiz
  class QuizRunner
    def initialize(file)
      @file = file
    end

    def run
      puts @file
    end
  end
end
