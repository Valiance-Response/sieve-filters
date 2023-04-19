require ["fileinto", "mailbox"];

# Define the folder where you want to move the mailing list and email subscription emails
set "mailing_list_folder" "INBOX/Mailing Lists";

# Define the mailing list and email subscription email addresses
# You can add more addresses by separating them with a comma
# Make sure to enclose the addresses in double quotes
set "mailing_list_addresses" "mailinglist@example.com", "mailinglist@example.com", "subscription@example.com";

# Create a rule to match emails sent from the mailing list and email subscription addresses
if anyof (header :contains "From" "${mailing_list_addresses}") {
  # Move the email to the specified folder
  fileinto :create "${mailing_list_folder}";
}
