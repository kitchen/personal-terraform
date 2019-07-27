this is kind of a poor man's dyndns type of setup. I would prefer to use AWS's provided ifconfig.me style service (I trust them more than I trust ifconfig.me) but their service doesn't respond with any content-type headers and terraform requires that for some reason.

the idea with this is eventually I'll have a credential configured on pohara that can update this record and I'll set it up in a cron job of sorts.
