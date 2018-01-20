#!/bin/bash

#
# Event handler script for disabling a web server node from an F5 via Ansible Tower.
#

hostname=${5}

function disable_node {
        response=`/usr/bin/curl -H "Content-Type: application/json" -X POST -d '{"username": "admin", "password":" CDCuG!2017"}' https://10.100.100.100/api/v2/authtoken/ --insecure`
        IFS='"' read -r -a token <<< "$response"
        /usr/bin/curl -H "Content-Type: application/json" -H "Authorization: Token ${token[3]}" -X POST -d '{"extra_vars": "{\"api_hostname\": \"'${hostname}'\"}"}' https://10.100.100.100/api/v2/job_templates/13/launch/ --insecure
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
