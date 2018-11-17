class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
  #  create
    @figure = Figure.create(name: params["figure"]["name"])
  #titles
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    else
      @figure.title_ids = params["figure"]["title_ids"]
    end
#new landmarks
  if !params["landmark"]["name"].empty?
    @figure.landmarks << Landmark.create(name: params["landmark"]["name"], figure_id: @figure.id, year_completed: params[""])
  else
    @figure.landmark_ids = params["figure"]["landmark_ids"]
  end
    @figure.save
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    if !params["figure"]["name"].empty?
      @figure.name = params["figure"]["name"]
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    else
      @figure.title_ids = params["figure"]["title_ids"]
    end
#new landmarks
  if !params["landmark"]["name"].empty?
    @figure.landmarks << Landmark.create(name: params["landmark"]["name"], figure_id: @figure.id, year_completed: params[""])
  else
    @figure.landmark_ids = params["figure"]["landmark_ids"]
  end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
