module ChartsHelper
  def recent_users_line_data
    Rails.cache.fetch('recent_users_line_data', expires_in: 1.hour) do
      User.group_by_day(:created_at,
                        range: 1.weeks.ago.midnight..Time.zone.now,
                        format: '%m-%d').count
    end
  end
end
