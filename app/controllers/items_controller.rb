class ItemsController < ApplicationController

  def index
		if params[:user_id]
			user = User.find(params[:user_id])
			items = user.items
		else
			items = Item.all
		end
    render json: items, include: :user
	rescue ActiveRecord::RecordNotFound => error
		render json: { message: error.message }, status: :not_found
  end

	def show
		item = Item.find(params[:id])
		render json: item, status: :ok
	rescue ActiveRecord::RecordNotFound => error
		render json: { message: error.message }, status: :not_found
	end

	def create
		if params[:user_id]
			user = User.find(params[:user_id])
			item = Item.create(item_params)
			render json: item, status: :created
		end
	end

	private

	def item_params
		params.permit(:name, :description, :price, :user_id)
	end

end
