module ApplicationCable
  class Connection < ActionCable::Connection::Base

 #   def connect
 #     self.current_user = find_verified_user      
 #   end

 #   private

 #   def find_verified_user
 #     if (verified_user = env['warden'].user)
 #       verified_user
 #     else
 #       reject_unauthorized_connection
 #     end    
 #   end
  end
end
