#!/bin/sh

############################################################################################################
###                                         Backup files and database                                    ###
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

# Default parameters
type=full
ydisk=false

while [ -n "$1" ]
	do
		case "$1" in
			full) echo "Found the \"full\" option"; type=full ;;
			db) echo "Found the \"db\" option"; type=db ;;
			yandexdisk) echo "Found the \"yandexdisk\" option"; ydisk=true ;;
		esac
		shift
	done

# Create archive filename
day=$(date +%F-%H-%M)
hostname=$(hostname -s)
archive_file="$hostname-$name-$type-$day.xz"

# Create temp folder
mkdir -p "$temp_path"

# Create folder to keep backups
mkdir -p "$dest"

# Dump MySQL
mysqldump $dbname --host=$dbhost --user=$dbuser --password=$dbpassword --default-character-set=utf8 > "$tempsql"

# Compress backup files using tar and xz
if [ $type = "full" ]; then tar cP --xz --file="$dest/$archive_file" --exclude-from="$exclude_list" "$tempsql" "$backup_files"; fi	# full - backup database and files
if [ $type = "db" ]; then tar cP --xz --file="$dest/$archive_file" "$tempsql"; fi																	# db - backup database only

# Clear temp files
rm "$tempsql"

# Delete old backups
find $dest -mtime +$days -regex ".*$type.*" -type f -exec rm -f {} \;

if [ ydisk = "true" ]
	then
		# Encrypt backup
		gpg -e -r "$user_id" $dest/$archive_file

		# Send backup to Yandex Disk
		curl -v --user $yandexdisk_email:$yandexdisk_pass -T "$dest/$archive_file.gpg" "https://webdav.yandex.ru/${yandexdisk_dir}/backup_${name}_${type}.xz.gpg"

		# Delete encrypted file
		rm -f $dest/*.gpg
fi