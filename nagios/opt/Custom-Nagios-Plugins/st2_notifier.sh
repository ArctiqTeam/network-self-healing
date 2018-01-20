#!/bin/bash

#
# Event handler script for disabling a web server node from an F5 via Ansible Tower.
#

hostname=${5}

function st2_notifier {
       python /opt/nagios/libexec/st2service_handler.py /opt/nagios/libexec/st2service_handler.yaml $SERVICEEVENTID$ "$SERVICEDESC$" $SERVICESTATE$ $SERVICESTATEID$ $SERVICESTATETYPE$ $SERVICEATTEMPT$ $HOSTNAME$
}

# What state is the HTTP service in?
case "$1" in

OK)
        # The service just came back up, so don't do anything...
;;


WARNING)
        echo -n "(warning state)..."
	disable_node

;;

UNKNOWN)
        # We don't know what might be causing an unknown error, so don't do anything...
;;

CRITICAL)
        # Aha!  The HTTP service appears to have a problem - perhaps we should restart the server...
        # Is this a "soft" or a "hard" state?

        case "$2" in

        # We're in a "soft" state, meaning that Nagios is in the middle of retrying the
        # check before it turns into a "hard" state and contacts get notified...

        SOFT)
                # run traceroute at every step of the way during a failed check

                case "$3" in
                1)
                        echo -n "(1st soft critical state)..."
			disable_node
                ;;

                2)
                        echo -n "(2nd soft critical state)..."
			disable_node
                ;;

                3)
                        echo -n "(3rd soft critical state)..."
			disable_node
                ;;
                esac
        ;;

        HARD)
                echo -n "(hard critical state)..."
		disable_node
        ;;
        esac
;;
esac

exit 0
