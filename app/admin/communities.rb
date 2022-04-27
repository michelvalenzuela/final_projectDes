ActiveAdmin.register Community do
    permit_params :account, :name, :url, :rules, :summary

end