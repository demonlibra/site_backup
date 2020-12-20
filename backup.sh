#!/bin/sh

############################################################################################################
#                                         Backup files and database                                        #
############################################################################################################

# --------------------- PARAMETERS -------------------------------------------------------------------------

days=30											# Days to keep backup

temp_path="tmp"								# Temp folder
name="forum"									# e.g. forum, crm, site, ...
tempsql="$temp_path/$name""backup.sql"	# Name temporary file with backup of database
dest="backup"									# Destination folder for backup archives
backup_files="docs"							# Folder with files which need to be backup
exclude_list="exclude.txt"					# Exclude list of files and folders from backup

dbhost="localhost"							# Host of database
dbname="forum"									# Database name
dbuser="root"									# User name
dbpassword=""									# Password

yandexdisk_email=''							# Mail yandex.disk
yandexdisk_pass=''							# Password yandex.disk
yandexdisk_dir='backup'						# Path in yandex.disk to save 

user_id="username"							# User id for asymmetric encrypt. Don't forget to import key.

# --------------------- SCRIPT -----------------------------------------------------------------------------

# Get parameter from command line: db - only DataBase; full - DataBase and Files
if [ $1 != "full" ] && [ $1 != "db" ]
	then type=full
	else type=$1
fi

# Create archive filename
day=$(date +%F-%H-%M)
hostname=$(hostname -s)
archive_file="$hostname-$name-$type-$day.tgz"

# Create temp folder
mkdir -p "$temp_path"

# Create folder to keep backups
mkdir -p "$dest"

# Dump MySQL
mysqldump $dbname --host=$dbhost --user=$dbuser --password=$dbpassword --default-character-set=utf8 > "$tempsql"

# Compress backup files using tar
if [ $type = "full" ]; then tar czPf "$dest/$archive_file" --exclude-from="$exclude_list" "$tempsql" "$backup_files"; fi	# full - backup database and files
if [ $type = "db" ]; then tar czPf "$dest/$archive_file" "$tempsql"; fi																		# full - backup database only

# Clear temp files
rm "$tempsql"

# Delete old backups
find $dest -mtime +$days -regex ".*$type.*" -type f -exec rm -f {} \;

if [[ "$yandexdisk_email" != "" ]] && [[ "$yandexdisk_pass" != "" ]] && [[ "$user_id" != "" ]]
	then
		# Encrypt backup
		gpg --encrypt --recipient "$user_id" $dest/$archive_file

		# Send backup to Yandex Disk
		curl -v --user $yandexdisk_email:$yandexdisk_pass -T $dest/$archive_file.gpg "https://webdav.yandex.ru/$yandexdisk_dir/backup_""$name""_$type.tgz.gpg"

		# Delete encrypted file
		rm -f $dest/*.gpg
fi