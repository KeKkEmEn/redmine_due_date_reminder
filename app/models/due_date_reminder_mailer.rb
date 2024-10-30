# plugins/redmine_due_date_reminder/app/models/due_date_reminder_mailer.rb
class DueDateReminderMailer < Mailer
  def send_reminder(issue)
    recipients = issue.assigned_to.try(:mail)
    mail(to: recipients, subject: "Reminder: Issue ##{issue.id} is due soon") do |format|
      format.text { render plain: "This is a reminder that issue ##{issue.id} is due on #{issue.due_date}." }
    end
  end
end
