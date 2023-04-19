require ["fileinto", "regex"];

if anyof (header :contains "Subject" "two-factor code",
          header :contains "Subject" "verification code",
          header :contains "Subject" "authentication code",
          regex :matches "body" "[0-9]{6}")
{
    fileinto "2FA codes";
}
