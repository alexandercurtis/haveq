# haveq (have-q)

29/9/2016

"Have I already got this file somewhere?"

Have is a bash script that checks each file in the current directory against an index of md5sums, to see if the file already exists on my NAS. Useful for finding duplicate files.

Format of index file is 

    ab67e817bf24bd7226602b6929dd8d24  ./.asadminpass
    22bfb8c1dd94b5f3813a2b25da67463f  ./.bash_logout

Index file can be generated by 

    find /mnt/diskstation/shared -type f -exec md5sum {} \; > /mnt/diskstation/shared/index.txt

