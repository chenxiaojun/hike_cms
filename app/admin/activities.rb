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
end
