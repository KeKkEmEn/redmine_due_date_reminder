# plugins/redmine_due_date_reminder/init.rb
require 'redmine'

Redmine::Plugin.register :redmine_due_date_reminder do
  name 'Due Date Reminder'
  author 'L Stuiver'
  description 'Sends email reminders when issues are about to be due'
  version '1.0.1'
  requires_redmine version_or_higher: '5.1.2'

  settings default: {
    'reminder_days_before' => 3
  }, partial: 'settings/due_date_reminder_settings'
end

# Hook into the issue model to send reminders
require_dependency 'due_date_reminder'
