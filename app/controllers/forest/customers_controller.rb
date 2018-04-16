class Forest::CustomersController < ForestLiana::ApplicationController
    def block_customer
        customer_id = params.dig('data', 'attributes', 'ids').first
        Customer.update(customer_id, blocked: true)
        head :no_content
    end

    def unblock_customer
        customer_id = params.dig('data', 'attributes', 'ids').first
        Customer.update(customer_id, blocked: false)
        head :no_content
    end
end