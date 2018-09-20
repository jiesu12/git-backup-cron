## Usage
Create directory `git_backup_key` under `/path/to/backup_mount_point`. Put key which can checkout git under there.

```
docker run -d -v /path/to/backup_mount_point:/volume -e SCHEDULE='* * * * *' --name cron-git-backup jiesu/cron-git-backup
```

