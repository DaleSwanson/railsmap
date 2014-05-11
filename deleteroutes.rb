ActiveRecord::Base.transaction do
  Routes = Route.where(park_id: 2)
  Routes.each do |route|
    route.destroy
  end
end
