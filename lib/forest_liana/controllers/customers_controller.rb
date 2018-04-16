if ForestLiana::UserSpace.const_defined?('CustomerController')
    ForestLiana::UserSpace::CustomerController.class_eval do
      # We register the default behavior method to default_destroy before the override.
      alias_method :default_destroy, :destroy
  
      def destroy
        teams = forest_user.dig('data', 'data', 'teams')
        
        if teams.include?('Management')
          default_destroy
        else
          render status: 403, plain: 'Sorry, you\'re not allowed to delete a customer. Ask someone in the Management team.'
        end
      end
    end
  end