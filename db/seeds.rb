# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'cpf_cnpj'

Status.create!([
                 { name: 'Aberto' },
                 { name: 'Em progresso' },
                 { name: 'Em impedimento' },
                 { name: 'Pronto' }
               ])

Category.create!([
                   { name: 'Front' },
                   { name: 'Back' },
                   { name: 'Support' }
                 ])

User.create!([
               {
                 first_name: 'João',
                 last_name: 'Silva',
                 email: 'joao.silva@example.com',
                 phone: '1199887766',
                 cpf: CPF.generate,
                 gender: 0
               },
               {
                 first_name: 'Maria',
                 last_name: 'Santos',
                 email: 'maria.santos@example.com',
                 phone: '2199776655',
                 cpf: CPF.generate,
                 gender: 1
               },
               {
                 first_name: 'Pedro',
                 last_name: 'Oliveira',
                 email: 'pedro.oliveira@example.com',
                 phone: '45999802098',
                 cpf: CPF.generate,
                 gender: 0
               }
             ])

users = User.all
categories = Category.all
statuses = Status.all

10.times do
  Activity.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph,
    category_id: categories.sample.id,
    status_id: statuses.sample.id,
    public: Faker::Boolean.boolean,
    user_id: users.sample.id
  )
end
