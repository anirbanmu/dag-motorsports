# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
seeds_path = Rails.root.join('db', 'seeds')

platform_seeds = YAML::load_file(File.join(seeds_path, 'platforms.yml'))
platform_seeds.each do |platform|
  Platform.find_or_create_by!(name: platform)
end

game_seeds = YAML::load_file(File.join(seeds_path, 'games.yml'))
game_seeds.each do |game_properties|
  game = Game.find_or_initialize_by(name: game_properties.fetch('name'))
  game.release = game_properties.fetch('release')
  game.developer = game_properties.fetch('developer')
  game.publisher = game_properties.fetch('publisher')
  game.save!

  game_properties.fetch('platforms').each do |platform|
    GamePlatformAssociation.find_or_create_by!(game: game, platform: Platform.find_by(name: platform))
  end

  image_property = game_properties['image']

  # Destroy old image if new image is blank
  if image_property.blank?
    next unless game.image
    game.image.destroy
  end

  next if image_property.blank?

  cover_image_path = File.join(seeds_path, 'images', 'games', 'covers')

  generated_image_properties = Image.properties_from_url(File.join(cover_image_path, image_property))
  image = Image.find_or_initialize_by(id: game.image)
  image.filename = generated_image_properties[:filename]
  image.base64 = generated_image_properties[:base64]
  image.mimetype = generated_image_properties[:mimetype]
  image.imageable = game
  image.save!
end
