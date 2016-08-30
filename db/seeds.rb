# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Setting.create!(key: 's3_bucket')
Setting.create!(key: 's3_region')
Setting.create!(key: 's3_access_key_id')
Setting.create!(key: 's3_secret_access_key')
