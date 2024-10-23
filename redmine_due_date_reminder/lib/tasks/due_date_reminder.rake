# plugins/redmine_due_date_reminder/lib/tasks/due_date_reminder.rake
namespace :redmine_due_date_reminder do
    desc "Send reminders for upcoming due issues"
    task :send_reminders => :environment do
      days_before = Setting.plugin_redmine_due_date_reminder['reminder_days_before'].to_i
      reminder_date = Date.today + days_before
  
      issues = Issue.where(due_date: reminder_date)
      issues.each do |issue|
        DueDateReminderMailer.reminder(issue, days_before).deliver_now if issue.assigned_to.present?
      end
    end
  end
  