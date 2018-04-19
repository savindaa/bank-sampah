if ForestLiana::UserSpace.const_defined?('CustomerController')
    ForestLiana::UserSpace::CustomerController.class_eval do
      # We register the default behavior method to default_destroy before the override.
      alias_method :default_destroy, :destroy
  
      def destroy
        teams = forest_user.dig('data', 'data', 'teams')
        default_destroy
      end
    end
  end