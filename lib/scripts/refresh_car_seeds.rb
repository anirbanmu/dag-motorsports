#!/usr/bin/env ruby

require_relative '../../config/environment'
require 'open-uri'

def get_html(url)
  open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE){|f|f.read}
end

def update_cars_yml(seed_file, game, cars)
  game_car_seeds = { game: game }
  game_car_seeds[:cars] = cars.map{ |car| { name: car } }

  seeds_path = Rails.root.join('db', 'seeds')
  car_seeds_path = File.join(seeds_path, seed_file)
  car_seeds = YAML::load_file(car_seeds_path)
  car_seeds.delete_if{ |o| o[:game] == game }
  car_seeds.push game_car_seeds

  File.open(car_seeds_path, 'w') {|f| f.write car_seeds.to_yaml }
end

def refresh_forza
  html = Nokogiri::HTML(get_html('https://www.forums.forzamotorsport.net/turn10_postst99201_FM7-Car-List.aspx'))
  post = html.search('.postContentDiv').first
  cars = post.to_s.scan(/(?:br>|li>)(\d\d\d\d\s+[a-zA-Z]+.+?)[<|▼|❹|❼]/).map { |car| Nokogiri::HTML.parse(car.first.gsub(/\s+/, ' ').strip).text }
  update_cars_yml('cars.yml', 'Forza Motorsport 7', cars)
end

def refresh_gtsport
  html = Nokogiri::HTML(get_html('https://www.gran-turismo.com/us/products/gtsport/carlist/'))
  car_nodes = html.search('dl:not([class])')
  cars = car_nodes.map{ |n| n.search('dd').take(2).map{ |t| t.text.strip } }
  cars = cars.map do |manufacturer, model|
    model_sanitized = model.sub(/^\s*#{manufacturer}\s*/i, '')
    "#{manufacturer} #{model_sanitized}"
  end
  update_cars_yml('cars.yml', 'Gran Turismo Sport', cars)
end

def refresh_assetto
  html = Nokogiri::HTML(get_html('http://www.assettocorsa.net/cars/'))

  cars = []
  html.search('#marchi').first.search('.row.no-gutters').each do |m|
    # Not foolproof for casing. If 3 letters or less, name is assumed to be an acronym and upcased.
    manufacturer = m.search('h3').first.text.split.map{ |w| w.length > 3 ? w.capitalize : w.upcase }.join(' ').strip
    cars.push(*m.search('p').map{ |c| "#{manufacturer} #{c.text.strip}" })
  end

  update_cars_yml('cars.yml', 'Assetto Corsa', cars)
end

refresh_forza
refresh_gtsport
refresh_assetto
