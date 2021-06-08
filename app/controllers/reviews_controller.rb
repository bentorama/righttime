class ReviewsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @order = Order.new
  end

  def create
    @review = Review.new(review_params)
    @order = Order.find(params[:order_id])
    @review.order = @order
    @review.save!
  end

  private

  def review_params
    sparams.require(:review).permit(:order_id, :event_review, :venue_rating)
  end
end
