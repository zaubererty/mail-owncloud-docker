# mail-owncloud-docker
**Contents:**
- postfix smtp mailserver with virtual domains/users and authentication
  via imap
- postfixadmin to administer email domains/mailboxes
- dovecot imap server
- dovecot sieve for filtering rules
- spamassassin for spam filtering

# Example usage

NB: when you want persistence storage, please mount it under /data (see example below for host path), and all data will be moved there.

Expose everything public:
```
docker run -d \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v <path to data on host>:/data \
  -p 143:143 -p 993:993 -p 4190:4190 -p 25:25 -p 465:465 \
  --name mycloud -h <FQDN of host> \
  idef1x/mail-owncloud-docker
```
# Optional environment vars to use:
```
- SQLUSR  => mysql user
- SQLPWD  => mysql password
- SQLHOST => mysql server
- SQLDB   => mysql dbname
- PASS_SCHEME => default pass scheme for dovecot
```
# To use own certificates:
```
- For Apache certificates add parameters:
  for cert: -v <path to SSL cert>:/etc/ssl/certs/ssl-cert-snakeoil.pem
  for key : -v <path to SSL key>:/etc/ssl/private/ssl-cert-snakeoil.key

- For dovecot/postfix certificates add parameters:
  for cert: -v <path to SSL cert>:/etc/dovecot/dovecot.pem
  for key : -v <path to SSL cert>:/etc/dovecot/private/dovecot.pem
```

# Logging
- all logging is sent to a stdout and stderr

# Networks
- 10.0.0.0/8
- 127.0.0.0/8
