TRANS_TOPIC_STATUSES = Topic.statuses.keys.collect { |d| [I18n.t("status.#{d}"), d] }
ActiveAdmin.register Topic do
  menu priority: 10
  actions :all, except: [:new, :create, :edit, :update, :destroy]

  filter :title
  filter :body
  filter :user_id
  filter :created_at, as: :date_range

  index do
    render 'index', context: self
  end

  show do
    render 'show'
  end

  controller do
    def scoped_collection
      Topic.includes(:topic_counter)
    end
  end

  member_action :excellent, method: :post do
    resource.excellent!
    redirect_back fallback_location: admin_topics_url, notice: I18n.t('publish_notice')
  end

  member_action :unexcellent, method: :post do
    resource.unexcellent!
    redirect_back fallback_location: admin_topics_url, notice: I18n.t('unpublish_notice')
  end

  member_action :change_status, method: :put do
    resource.update(status: params[:status])
    render json: resource
  end

  member_action :likes, method: :get do
    @page_title = "点赞列表 (#{resource.likes_count})"
    @like_by_users = resource.like_by_users.page(params[:page]).per(10)
  end

  member_action :views, method: [:get, :post] do
    view_toggle = resource.view_toggle
    unless request.post?
      @common_view_toggle = view_toggle.present? ? view_toggle : ViewToggle.new
      return render :toggle_view
    end
    on_off = params[:on_off].eql?('on') ? true : false
    hot = params[:type].eql?('hot') ? true : false
    # 判断之前是否有保存过
    create_params = { target: resource,
                      toggle_status: on_off,
                      hot: hot,
                      begin_time: Time.zone.now,
                      last_time: Time.zone.now }
    view_toggle.present? ? view_toggle.update(create_params) : ViewToggle.create(create_params)
    redirect_back fallback_location: admin_topics_url, notice: '更改成功'
  end
end
