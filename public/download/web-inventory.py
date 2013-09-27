#!/usr/bin/python

import os
import sys
import argparse
import urllib2
import ConfigParser

server = ""
inventory_id = 0
api_key = ""

def read_settings():
        ''' Reads the settings from the digital_ocean.ini file '''
        config = ConfigParser.SafeConfigParser()
        config.read(os.path.dirname(os.path.realpath(__file__)) + '/web-inventory.ini')

        # Credentials
        if config.has_option('web-inventory', 'server'):
            global server 
            server = config.get('web-inventory', 'server')

        if config.has_option('web-inventory', 'inventory_id'):
            global inventory_id 
            inventory_id = config.get('web-inventory', 'inventory_id')

        if config.has_option('web-inventory', 'api_key'):
            global api_key 
            api_key = config.get('web-inventory', 'api_key')

def main(argv):  
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true')
    parser.add_argument('--host')
    args = parser.parse_args()
    

    if args.list:
        read_settings()

        request = urllib2.Request('%s/ansible/inventory/%s.json' % (server, inventory_id), headers={"Authorization" : "Token token=\"%s\"" % api_key})
        print urllib2.urlopen(request).read()
        sys.exit(0)
    elif args.host:
        read_settings()

        request = urllib2.Request('%s/ansible/inventory/%s/%s.json' % (server, inventory_id, args.host), headers={"Authorization" : "Token token=\"%s\"" % api_key})
        print urllib2.urlopen(request).read()
        sys.exit(1)
    else:
        parser.print_help()


if __name__ == "__main__":
    main(sys.argv[1:])