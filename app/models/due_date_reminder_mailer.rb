# plugins/redmine_due_date_reminder/app/models/due_date_reminder_mailer.rb
class DueDateReminderMailer < Mailer
    def reminder(issue, days_left)
      @issue = issue
      @days_left = days_left
      mail to: issue.assigned_to.mail, subject: "Reminder: Issue ##{issue.id} is due in #{@days_left} days"
    end
  end
  