class Flight
  attr_reader :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
  
  private
  attr_writer :database_handle
end

=begin
Since the @database_handle is initialized and assigned to an object created by 
the Database class, we don't want a re-assignment of this variable allowed
by any code outside of the Flight class.  

=end