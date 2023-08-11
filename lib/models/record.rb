require 'csv'
require 'securerandom'

class Record
  BASE_PATH = "#{File.dirname(__FILE__)}/../config/database/"

  def to_h
    object = {}
    self.instance_variables.each do |variable| # :@id
      object[variable.to_s.delete('@').to_sym] = self.instance_variable_get(variable)
    end
    object
  end

  def self.all
    begin
      table = CSV.read("#{BASE_PATH}#{self.to_s.downcase}.csv", headers: true)
    rescue
      return {}
    end

    table.map do |item|
      data = item.to_h.transform_keys(&:to_sym)
      self.new(**data)
    end
  end

  def self.create(args)
    args = { id: SecureRandom.uuid, **args }

    unless File.file?("#{BASE_PATH}#{self.to_s.downcase}.csv")
      mode = 'wb'
      write_headers = true
    else
      mode = 'a+'
      write_headers = false
    end

    CSV.open("#{BASE_PATH}#{self.to_s.downcase}.csv", mode, write_headers: write_headers, headers: args.keys) do |csv|
      csv << args.values
    end

    args
  end

  def self.destroy(id)
    table = CSV.table("#{BASE_PATH}#{self.to_s.downcase}.csv")

    table.delete_if do |row|
      row[:id] == id
    end

    File.open("#{BASE_PATH}#{self.to_s.downcase}.csv",'w') do |file|
      file.write(table.to_csv)
    end
  end
end
