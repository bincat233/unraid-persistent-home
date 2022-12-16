This script create symlinks from `/boot/config/home_root` to `/root`

Install it with:

``` bash
curl -s https://raw.githubusercontent.com/RRRRRm/unraid-persistent-home/main/install.sh | bash
```

Usage:

```
Usage: init_home.sh [OPTION]
  -l, --link		Link the files in /boot/config/home_root to /root
  -p, --push		Push the files in /root to /boot/config/home_root
  -f, --force		Force to remove the file if it is exist
  -h, --help		Show this help
```

You can use `init_home.sh -lf` to create a link regardless of whether the target path already exists.
