class PrinterController < ApplicationController
  before_action :authenticate_user, :get_booking

  def print
    render pdf: "print", layout: "pdf.html.erb"
  end

  def download
    html = render_to_string("print", layout: "pdf.html.erb")
    pdf = WickedPdf.new.pdf_from_string(html)
    send_data(pdf, filename: "#{@event.title.downcase}.pdf")
  end

  private

  def get_booking
    booking = current_user.bookings.find_by(id: params[:booking_id])
    if booking.nil? || booking.granted
      flash[:notice] = booking_not_found
      redirect_to tickets_path
    else
      set_tickets(booking)
    end
  end

  def set_tickets(booking)
    @event = booking.event
    @user_tickets = booking.user_tickets
    if params[:ticket_type_id]
      id = params[:ticket_type_id]
      @user_tickets = @user_tickets.where(ticket_type_id: id)
    end
  end
end
