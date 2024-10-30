# plugins/redmine_due_date_reminder/app/models/due_date_reminder_mailer.rb
class DueDateReminderMailer < Mailer
  def send_reminder(issue)
    recipients = issue.assigned_to.try(:mail)
    # Create a journal for the issue if needed (optional)
    journal = issue.journals.build
    issue_edit(recipients, issue, journal)  # Pass the journal as the third argument
  end

  def issue_edit(recipient_user, issue, journal = nil)
    # This method is called for sending the email
    @issue = issue
    @journal = journal

    mail(to: recipient_user, subject: "Reminder: Issue ##{issue.id} is due soon") do |format|
      format.text { render plain: "This is a reminder that issue ##{issue.id} is due on #{issue.due_date}." }
    end
  end
end
