# ejabberd
# Unregister Party
# 
# Purpose: Removes accounts matching a given regular expression
# Author: Valerian Saliou
# XMPP: valerian@jappix.com
# Website: http://valeriansaliou.name/
# 
# Project: Jappix
# License: GPL

# Imports
import os, re

# Configuration
EJABBERDCTL = 'ejabberdctl'

# Get XMPP host
xmpp_host = raw_input('Which XMPP host? ')

# Bad input?
while not xmpp_host:
	xmpp_host = raw_input('Well? ')

# Get filter regex
filter_regex_str = raw_input('Filter regex? ')

# Bad input?
while not filter_regex_str:
	filter_regex_str = raw_input('Uh? ')

# Get user list
print 'Partying...'

filter_list = []
p = os.popen(EJABBERDCTL + ' registered_users ' + xmpp_host, 'r')
filter_regex = re.compile(filter_regex_str)

while 1:
	# Read current line
	line = p.readline()
	
	if not line:
		break
	
	# Check if current line is a filtered user
	line = line.strip()
	
	if filter_regex.match(line):
		filter_list.append(line)

# Anything to remove?
filter_count = len(filter_list)

if filter_count > 0:
	# Remove?
	remove = False
	remove_str = raw_input('Remove ' + str(filter_count) + ' users? (y/n) ')
	
	# Bad input?
	while remove_str != 'n' and remove_str != 'y':
		remove_str = raw_input('Please answer y/n (yes/no) ')
	
	# Filter prompt results
	if remove_str == 'y':
		remove = True
	
	# Go Go Go!
	if remove == True:
		# Simulate?
		simulate = True
		simulate_str = raw_input('Simulate removal? (y/n) ')
		
		# Bad input?
		while simulate_str != 'n' and simulate_str != 'y':
			simulate_str = raw_input('Please answer y/n (yes/no) ')
		
		if simulate_str == 'n':
			simulate = False
		
		print 'Starting removal...'
		print '---'
		
		# Index each iteration
		current_index = 0
		
		for current_filter in filter_list:
			# Process current percent done
			current_index = current_index + 1
			current_percent = int((float(current_index) / float(filter_count)) * 100)
			
			# Space well output
			current_spaces = 2
			
			if current_percent < 10:
				current_spaces = 3
			elif current_percent == 100:
				current_spaces = 1
			
			# Generate current progress string
			current_progress = '[' + str(current_percent) + '%]' + (' ' * current_spaces)
			
			# Are we simulating?
			if simulate == False:
				print current_progress + 'Removing ' + current_filter + '@' + xmpp_host + '...'
				
				os.popen(EJABBERDCTL + ' unregister ' + current_filter + ' ' + xmpp_host, 'r')
			else:
				print current_progress + 'Simulating removal of ' + current_filter + '@' + xmpp_host + '...'
		
		print '---'
		print '100%. Done. Let\'s party hard now!'
	else:
		print 'Aborted. Done.'
else:
	print 'Nothing to remove, seems clean!'