ActiveAdmin.register Activity do
  menu priority: 12
  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :name
  filter :departure_city
  filter :destination
  filter :created_at, as: :date_range

  index do
    render 'index', context: self
  end

  show do
    render 'show'
  end

  member_action :members, method: :get do
    @page_title = "报名列表(报名: #{resource.apply_numbers} ，已通过: #{resource.join_numbers})"
    @members = resource.activity_joins.page(params[:page])
  end
end
