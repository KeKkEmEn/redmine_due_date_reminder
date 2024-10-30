# plugins/redmine_due_date_reminder/app/models/mailer.rb
class DueDateReminderMailer < Mailer
  # Method to send the due date reminder
  def send_reminder(issue, recipient_user)
    recipients = recipient_user.try(:mail)
    
    return if recipients.blank?  # Exit if no recipient is found

    mail(to: recipients, subject: "Reminder: Issue ##{issue.id} is due soon") do |format|
      format.text { render plain: "This is a reminder that issue ##{issue.id} is due on #{issue.due_date}." }
    end
  end

