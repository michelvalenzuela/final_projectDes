ActiveAdmin.register Post do
    permit_params :account, :community, :title, :body, :upvotes, :downvotes, :total_comments

end