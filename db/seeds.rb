# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "rigo@test.com", uid:"000222333666", provider: "github")

pool = MyPool.create(title: "Que lenguaje manejas?", description:"Descripcion generica", expires_at: DateTime.now + 6.months, user: user)

question = Question.create(description: "Te importa la eficiencia la pregunta", my_pool: pool)

answer = Answer.create(description: "si me importa para la prueba", question: question)
