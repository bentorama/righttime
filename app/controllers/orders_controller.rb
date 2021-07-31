class OrdersController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    order = Order.create!(event: event, event_sku: event.sku, amount: params[:order_amount], state: 'pending', user: current_user)
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: event.name,
        # images: [event.photo_url]
        amount: order.amount_cents,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)  
    redirect_to new_order_payment_path(order)
    authorize @orders
  end

  def show
    @order = current_user.orders.find(params[:id])
    destination
    authorize @orders
  end

  def my_bookings
    @orders = Order.where(user: current_user)
    authorize @orders
  end

  def directions
    @order = current_user.orders.find(params[:id])
    destination
  end

  private

  def destination
    @destination = {
      lat: @order.event.venue.latitude,
      lng: @order.event.venue.longitude,
      # info_window: render_to_string(partial: "info_window", locals: { event: event }),
      image_url: helpers.asset_url('stopwatch.png')
    }
    # raise
  end
end
