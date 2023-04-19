require "fileinto";

# Put all mails that have been sent without TLS/SSL into the spam folder and apply the no TLS label

if header :is "x-pm-transfer-encryption" "none" {
    fileinto "NO TLS/SSL";
    fileinto "Spam";
}
