# Сценарии для создания резервных копий сайта/форума/CRM/...

## Описание файлов
| Файл           | Описание                                     |
|----------------|----------------------------------------------|
| backup_db.sh   | Сценарий создания копии базы данных          |
| backup_full.sh | Сценарий создания копии базы данных и файлов |
| exclude.txt    | Список исключения при копировании файлов     |

## Параметры
Проверьте параметры в начале файла.

## Yandex.Disk
Возможна загрузка резервных копий на Yandex.Disk с предварительным шифрованием.  

[gpg - шифрование для всех платформ](http://www.opennet.ru/base/sec/gpg_crypt.txt.html)

## Восстановление базы данных из резервной копии
Для восстановления больших баз данных (и маленьких тоже) Я использую php сценарий [BigDump](https://www.ozerov.de/bigdump/).


# Scripts for backup site/forum/CRM/...

## Description of the files
| File           | Description                          |
|----------------|--------------------------------------|
| backup_db.sh   | Script for database backup           |
| backup_full.sh | Script for database and files backup |
| exclude.txt    | Exclude list of files                |

## Параметры
Check parameters at top of scripts.

## Yandex.Disk
It is possible to load backup to Yandex.Disk with encryption.

## Restore database
For big databse (and small too) I use simple php script by [BigDump](https://www.ozerov.de/bigdump/).  

[Quick'n easy gpg cheatsheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)