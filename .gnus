(setq gnus-select-method '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "steve.john.wang@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

(setq gnus-posting-styles
      '(((header "cc" ".*@berkeley.edu")
         (address "swang2014@berkeley.edu"))
        ((header "to" ".*@berkeley.edu")
         (address "swang2014@berkeley.edu"))
        ((header "to" ".*@nowjs.*")
         (address "steve@nowjs.org"))
        ((header "cc" ".*@nowjs.*")
         (address "steve@nowjs.org"))))
