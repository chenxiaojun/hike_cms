ActiveAdmin.register SmsLog do
  menu priority: 20
  config.batch_actions = false
  config.clear_action_items!
  config.sort_order = 'send_time_desc'

  filter :mobile
  filter :status
  filter :send_time

  index do
    id_column
    column :mobile, sortable: false
    column :content, sortable: false
    column :error_msg, sortable: false
    column :fee
    column :send_time
    column :arrival_time
    column :status, sortable: false
  end
end
