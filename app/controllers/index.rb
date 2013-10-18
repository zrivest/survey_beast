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
    session[:name] = @user.name
    redirect to('/survey_list')
  else
    redirect to '/'
  end 
end

get '/logout' do
  session.clear
  redirect to('/')
end

post '/sign_up' do
  @user = User.create(name: params[:name], password: params[:password], password_confirmation: params[:password], email: params[:email])
      @all_surveys = Survey.all 

  redirect to('/survey_list')
end

get '/survey_list' do
  @all_surveys = Survey.all 
  @user = User.find(session[:user_id])
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

get '/take_survey/:id' do 
  @survey = Survey.find(params[:id])
  erb :take_survey
end

post '/submit_survey' do
  # binding.pry
  params.each do |key,value| 
    @choice = Choice.where(question_id: key, answer: value)
   Response.create(user_id: session[:user_id], choice_id: @choice.first.id)
   redirect to('/your_answers')
  end
end

get '/your_answers' do
  @user = User.find(session[:user_id])
  @responses = Response.where(user_id: @user.id)
  binding.pry
  erb :your_answers
end

