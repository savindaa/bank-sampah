class Forest::BranchesController < ForestLiana::ApplicationController
    def block_branch
        branch_id = params.dig('data', 'attributes', 'ids').first
        Branch.update(branch_id, blocked: true)
        head :no_content
    end

    def unblock_branch
        branch_id = params.dig('data', 'attributes', 'ids').first
        Branch.update(branch_id, blocked: false)
        head :no_content
    end
end