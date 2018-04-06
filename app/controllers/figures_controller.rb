class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
    if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end

    if params["title"]["name"] != ""
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    if params["landmark"]["name"] != ""
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    end

    if params["figure"]["landmark_ids"] != ""
      params["figure"]["landmark_ids"].each do |landmark_id|
        @figure.landmarks << Landmark.find(landmark_id)
      end
    end
    params["landmark"]["name"]
    params["landmark"]["year_completed"]
  end
end
