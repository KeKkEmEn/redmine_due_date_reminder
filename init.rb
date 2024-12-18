# plugins/redmine_due_date_reminder/init.rb
require 'redmine'

Redmine::Plugin.register :redmine_due_date_reminder do
  name 'Due Date Reminder'
  author 'L Stuiver'
  description 'Sends email reminders when issues are about to be due'
  version '1.0.1'
  requires_redmine version_or_higher: '5.1.2'

  project_module :due_date_reminder do
    permission :send_due_date_reminder, { :due_date_reminder => [:send_reminder] }, :require => :loggedin
  end
  
  settings default: {
    'reminder_days_before' => 3
  }, partial: 'settings/due_date_reminder_settings'
end
