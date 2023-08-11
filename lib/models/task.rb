require_relative 'record'

class Task < Record
  attr_accessor :id, :title, :description
  
  def initialize(**args)
    @id = args[:id]
    @title = args[:title]
    @description = args[:description]
  end

  def self.list
    puts "Pressione a tecla Enter para retornar ao menu\n\n"
    self.all.each { |task| puts task.to_h }
    gets
  end

  def self.build
    puts self.create(hash_data_from_user_input)
    sleep 2
  end

  def self.hash_data_from_user_input
    title = ''
    description = ''

    while title.empty?
      puts 'Digite um título para a tarefa'
      title = gets.chomp
    end

    while description.empty?
      puts 'Digite ums descrição para a tarefa'
      description = gets.chomp
    end

    { title:, description: }
  end

  def self.remove
    id = ''

    while id.empty?
      puts 'Digite um id'
      id = gets.chomp
    end

    puts 'apagando...'
    sleep 2
    self.destroy(id)
  end
end
