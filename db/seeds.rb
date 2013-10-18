require 'faker'
require 'pry'

@all_users = []
@all_surveys = []
@all_users_with_survey_id = []

50.times do 
  name = Faker::Internet.user_name
  email = Faker::Internet.safe_email
  @all_users << User.create(name: name, password: "password", password_confirmation: "password", email: email)
end

surveys = 50.times do
  survey_name = Faker::Company.bs

end


50.times do 
  Question.create(content: Faker::Company.bs, survey_id: rand(1..50))
end 

50.times do 
  Choice.create(answer: Faker::Lorem.sentence, question_id: rand(1..50))
end


50.times do 
  Response.create(choice_id: rand(1..50), user_id: rand(1..50))
end

50.times do 
  CompletedSurvey.create(survey_id: rand(1..50), user_id: rand(1..50))

end
