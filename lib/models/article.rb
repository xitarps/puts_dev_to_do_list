require_relative 'record'

class Article < Record
  attr_accessor :id, :text, :date
  
  def initialize(**args)
    @id = args[:id]
    @text = args[:text]
    @date = args[:date]
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
    text = ''
    date = ''

    while text.empty?
      puts 'Digite um texto para a tarefa'
      text = gets.chomp
    end

    while date.empty?
      puts 'Digite uma data para o artigo'
      date = gets.chomp
    end

    { text:, date: }
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
