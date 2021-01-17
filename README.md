# Сценарий для создания резервных копий сайта/форума/CRM/...

## Описание файлов
|     Файл    |                Описание                      |
|-------------|----------------------------------------------|
|  backup.sh  | Сценарий создания копии базы данных и файлов |
| exclude.txt | Список исключения при копировании файлов     |

## Параметры сценария
Проверьте параметры в начале файла.

## Ключи сценария
|     Ключ    |                Описание                      |
|-------------|----------------------------------------------|
|      db     | Сценарий создания копии только базы данных   |
|     full    | Сценарий создания копии базы данных и файлов |
|  yandexdisk | Зашифровать копию и отправить на яндекс.диск |

## Запуск сценария
Добавьте в администраторской панели сайта исполнение сценария по расписанию:
```
cd "путь к каталогу со сценарием"; bash backup.sh full yandexdisk"
```
или
```
cd "путь к каталогу со сценарием"; bash backup.sh db yandexdisk"
```
## Yandex.Disk
Возможна загрузка резервных копий на Yandex.Disk с предварительным шифрованием.  

[gpg - шифрование для всех платформ](http://www.opennet.ru/base/sec/gpg_crypt.txt.html)

## Восстановление базы данных из резервной копии
Для восстановления больших баз данных (и маленьких тоже) Я использую php сценарий [BigDump](https://www.ozerov.de/bigdump/).


# Scripts for backup site/forum/CRM/...

## Description of the files
|    File     | Description                          |
|-------------|--------------------------------------|
|  backup.sh  | Script for database and files backup |
| exclude.txt | Exclude list of files                |

## Parameters
Check parameters at top of scripts.

## Keys
|     Key    |                Description                      |
|-------------|----------------------------------------------|
|      db     | Script for database only   |
|     full    | Script for database and files backup |
|  yandexdisk | Decrypt backup and send yandex.disk |

## Running
Add to admin panel of the site command to run script by schedule:
```
cd "path to folder with script"; bash backup.sh full yandexdisk"
```
or
```
cd "path to folder with script"; bash backup.sh db yandexdisk"
```

## Yandex.Disk
It is possible to load backup to Yandex.Disk with encryption.  
[Quick'n easy gpg cheatsheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/)

## Restore database
For big databse (and small too) I use simple php script by [BigDump](https://www.ozerov.de/bigdump/).