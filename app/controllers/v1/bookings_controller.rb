def destroy
    @booking = Booking.find(params[:id])
    @booking.update(archived_at: Time.current)

    redirect_to bookings_path, notice: 'Booking has been archived successfully.'
  end