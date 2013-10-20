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
    session[:user_id] = @user.id
    session[:name] = @user.name
  redirect to('/survey_list')
end

get '/survey_list' do
  @all_surveys = Survey.all 
  @user = User.find(session[:user_id])
  erb :survey_list 
end

post '/create_new_survey' do
  @title = params[:title]
  @survey = Survey.create(name: @title, user_id: session[:user_id] )# needs to be SESSION ID LATER!!!!
  erb :generate_questions
end

get '/create_new_survey' do 
  erb :create_new_survey,  :layout => false
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

get '/profile' do
  @user = User.find(session[:user_id])
  @user_surveys = @user.surveys
  erb :profile
end


get '/finished_survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  erb :finished_survey
end

get '/take_survey/:id' do 
  @survey = Survey.find(params[:id])
  session[:survey_id] = @survey.id
  erb :take_survey
end

post '/submit_survey' do
  CompletedSurvey.create(survey_id: session[:survey_id], user_id: session[:user_id])
  params.each do |key,value| 
    @choice = Choice.where(question_id: key, answer: value)
   Response.create(user_id: session[:user_id], choice_id: @choice.first.id)

  end
     redirect to('/your_answers')

end

get '/your_answers' do
  @survey_questions = []
  @user = User.find(session[:user_id])
  @this_survey = CompletedSurvey.last
  @survey = Survey.find(@this_survey.survey_id)
  @responses = @user.responses.last(3)
  erb :your_answers
end

get '/results/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  p @survey
  @number_taken = CompletedSurvey.where(survey_id: @survey.id).length
  p @number_taken
  erb :results, :layout => false
end

