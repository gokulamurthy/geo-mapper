module UsersHelper
  def is_night?(lat, lng)
    timezone = Timezone::Zone.new(:latlon => [lat, lng])
    midnight = timezone.time(Time.now).hour > 18 rescue false        
  end
end