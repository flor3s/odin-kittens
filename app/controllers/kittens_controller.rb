class KittensController < ApplicationController
	def index
		@kittens = Kitten.all

		respond_to do |format|
			format.json { render :json => @kittens }
		end
	end

	def show
		@kitten = Kitten.find(params[:id])

		respond_to do |format|
			format.json { render :json => @kitten }
		end
	end

	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.create(kitten_params)
		if @kitten.save
			flash[:info] = "Kitten created!"
			redirect_to @kitten
		else
			render 'new'
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		kitten = Kitten.find(params[:id])
		kitten.update!(kitten_params)
		redirect_to kitten
	end

	def destroy
		kitten = Kitten.find(params[:id])
		kitten.destroy!
		flash[:success] = "Kitten destroyed :("
		redirect_to kittens_url
	end

	private

		def kitten_params
			params.require(:kitten).permit(:name, :age, :cuteness, :softness)
		end 
end
