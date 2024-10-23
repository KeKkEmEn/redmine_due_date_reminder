# plugins/redmine_due_date_reminder/config/routes.rb
RedmineApp::Application.routes.draw do
  post 'issues/:id/send_due_date_reminder', to: 'due_date_reminder#send_reminder', as: 'send_due_date_reminder_issue'
end
