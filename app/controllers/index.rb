enable :sessions
require 'pry'

get '/' do
  # session.clear
  erb :index
end

post '/log_in' do
  @user = User.find_by_email(params[:email])

  # binding.pry
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    
    erb :survey_list
  else
    redirect to '/'
  end 
end

post '/sign_up' do
  user = User.new(params[:user])
  user.password = params[:password]

  if user.save
    session[:user_id] = user.id
    redirect to '/survey_list'
  else
    redirect to '/'
  end
end

get '/survey_list' do
  erb :survey_list 
end

post '/create_new_survey' do
  @title = params[:title]
  @survey = Survey.create(name: @title, user_id: 1 )# needs to be SESSION ID LATER!!!!
  erb :generate_questions
end


get '/create_new_survey' do 
  erb :create_new_survey
end


post '/add_question' do
  @question = Question.create(survey_id: params[:survey_id], content: params[:question] )
  Choice.create(question_id: @question.id, answer: params[:choice1])
  Choice.create(question_id: @question.id, answer: params[:choice2])
  Choice.create(question_id: @question.id, answer: params[:choice3])
  @survey = Survey.find(params[:survey_id])
  @title = @survey.name
  erb :generate_questions

end

get '/finished_survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :finished_survey
end

# get '/take_survey' do 
#   erb take_survey
# end

