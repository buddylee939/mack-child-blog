# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |p|
  Post.create!(
    title: "Post #{p}",
    content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sit sint, maiores suscipit fugiat nostrum tempora adipisci architecto eaque hic rem voluptatum accusamus, sequi."
  )
end

puts '20 posts created'


20.times do |p|
  Project.create!(
    title: "Project #{p}",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Error velit aspernatur reiciendis ipsa placeat sed sunt laboriosam aut, voluptate magni expedita veniam laborum quae tempore! Ad officiis magnam iusto vero!",
    link: "https://www.youtube.com/watch?v=ReVeUvwTGdU"
  )
end

puts '20 projects created'
