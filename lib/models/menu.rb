class Menu
  attr_reader :options

  def initialize
    @options = {
      0 => :exit,
      1 => :list_tasks,
      2 => :build_task,
      3 => :remove_task,
      4 => :list_articles,
      5 => :build_article,
      6 => :remove_article
    }
  end

  def dispĺay_menu
    @options.each do |option| # [0 , :exit]
      puts "#{option.first.to_s.center(5, ' ')} -> #{option.last}"
    end
  end
end
