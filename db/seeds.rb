# frozen_string_literal: true

require_relative 'bulk'
require_relative 'occurrence_generator'

def create_neighbours(neighbour_names)
  state = State.find_or_create_by(name: 'São Paulo')
  city = City.find_or_create_by(name: 'São Paulo', state: state)
  params = neighbour_names.to_set.to_a.map do |name|
    {
      city_id: city.id,
      name: name
    }
  end
  puts "Creating #{params.count} neighbours..."
  DB.insert_many(Neighbour, params)
end

def neighbours_id_from_name(name)
  if @neighbours_id_to_name.nil?
    @neighbours_id_to_name = {}
    Neighbour.all.each do |n|
      @neighbours_id_to_name[n.name] = n.id
    end
  end

  @neighbours_id_to_name[name]
end

def create_streets(street_params)
  params = street_params.map do |s|
    {
      cep: s[:cep],
      name: s[:street_name],
      neighbour_id: neighbours_id_from_name(s[:neighbour_name])
    }
  end

  puts "Creating #{params.count} sreets..."
  DB.insert_many(Street, params)
end

require 'csv'
csv_path = File.join File.dirname(__FILE__), '../csv/ceps_sp.csv'
neighbours_path = File.join File.dirname(__FILE__), '../csv/official_neighbours.txt'
# CEP,Logradouro,Bairro,X,Y
neighbour_names = []
street_params = []
puts 'Parsing csv...'
official_neighbours = File.readlines(neighbours_path).map { |c| c.strip.chop }
CSV.foreach(csv_path, headers: true) do |row|
  if row[1].present? && row[2].present? && official_neighbours.include?(row[2])
    street_params << {
        cep: row[0].gsub(/[^\d]/, ''),
        street_name: row[1],
        neighbour_name: row[2]
    }
    neighbour_names << row[2]
  end
end
create_neighbours neighbour_names
create_streets street_params
Generators.generate_occurrences
