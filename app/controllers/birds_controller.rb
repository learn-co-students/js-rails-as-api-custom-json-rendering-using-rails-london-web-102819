class BirdsController < ApplicationController
  def index
    @birds = Bird.all
    #👇to send the entire data set:
    # render json: @birds

    #👇 to send selected data with "only" option:
    render json: @birds, only: [:id, :name, :species]
  ## == equivalent to:
    # render json: @birds, except: [:created_at, :updated_at]
  
=begin
    the 'only' and 'except' keywords are actually parameters of the 'to_json' method
    obscured by Rails  implicitly takes arrays and hashes and convert them to JSON. 
    see equivalence: 
    def index
      birds = Bird.all
      render json: birds.to_json(execpt:[:created_at, :updated_at])
    end 
=end 
  
  end

  def show
    bird = Bird.find_by(id: params[:id])
    #👇 sending the ENTIRE data, hmmm... how to not send extra clutter that's not needed?
    # render json: bird
    
    #👇 to only send pieces of data as desired: 
    # render json:{id:bird.id, name: bird.name, species: bird.species}
  ## == equivalent to using Ruby's built-in 'slice' method:
    render json: bird.slice(:id, :name, :species)

 
=begin
error handeling: 
  when params[:id] returns nil (not found), nil as a false-y value in Ruby, gives us the ability to write our own error messages:
      def show
      bird = Bird.find_by(id: params[:id])
      if bird
        render json: bird.slice(:id, :name, :species)
      else
        render json: {message: "Bird not found"}
      end 
    end  
=end 

  end
end