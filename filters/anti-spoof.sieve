require ["fileinto", "imap4flags"];

# Mark emails that fail DMARC
if header :contains "Authentication-Results" "dmarc=fail" {
  # Check for anti-spoofing checks
  if anyof(
    header :contains "Authentication-Results" "dkim=pass",
    header :contains "Authentication-Results" "spf=pass",
    header :contains "Authentication-Results" "arc=pass"
  ) {
    addFlag "AUTH-INCOMPLETE";
  } else {
    # No anti-spoofing setup
    addFlag "AUTH-FAIL"
    fileinto "Spam";
    stop;
  }
}

# Put all mails that have been sent without TLS/SSL into the spam folder and apply the no TLS label
if header :is "x-pm-transfer-encryption" "none" {
    addFlag "NO TLS/SSL";
    fileinto "Spam";
}
