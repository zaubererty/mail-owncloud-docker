# Configure postfix /dovecot
if [ -z $SQLDB ]
  then SQLDB="mail"
fi

    # Create virtualhosts dir and user
    useradd -G mail -N -r -d /var/vmail -u 150 -m vmail
    chgrp -R mail /var/vmail
    chmod -R 770 /var/vmail
    chown -R vmail.mail /etc/dovecot
    # chown -R root.root /etc/postfix
    sed -i "s/ENABLED=0/ENABLED=1/g" /etc/default/spamassassin

    # Adapt configs to contain SQL password:
    sed -i "s/VAR_SQLPWD/$SQLPWD/g" /etc/postfix/*
    sed -i "s/VAR_SQLUSR/$SQLUSR/g" /etc/postfix/*
    sed -i "s/VAR_SQLHOST/$SQLHOST/g" /etc/postfix/*
    sed -i "s/VAR_SQLDB/$SQLDB/g" /etc/postfix/*

    sed -i "s/VAR_SQLPWD/$SQLPWD/g" /etc/dovecot/dovecot-sql.conf.ext
    sed -i "s/VAR_SQLUSR/$SQLUSR/g" /etc/dovecot/dovecot-sql.conf.ext
    sed -i "s/VAR_SQLHOST/$SQLHOST/g" /etc/dovecot/dovecot-sql.conf.ext
    sed -i "s/VAR_SQLDB/$SQLDB/g" /etc/dovecot/dovecot-sql.conf.ext

    # Configure postfix
    hostname > /etc/mailname
    postconf -e "myhostname = `cat /etc/hostname`"
    postconf -e "mydestination = `cat /etc/hostname`"
    postconf -e "inet_interfaces = all"

if [[ $MYNETWORKS ]]; then
  sed -i 's:^\(mynetworks =.*\):\1 '"$MYNETWORKS"':' /etc/postfix/main.cf
fi

    # Create sieve-scripts dir cause it's not done automaticaly
    mkdir /var/vmail/sieve-scripts
    chown -R vmail.mail /var/vmail/sieve-scripts
