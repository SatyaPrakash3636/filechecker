#!/bin/bash

script_dir="/users/home/user"
dir=feed_`date +"%Y%m%d"`
dir_path="/path/$dir"
d=`date`
t=`date +"%H%M"`
f1="file1"
f2="file2"
f3="file3"
f4="file4"
a1="08:30:00 EDT"
a2="08:30:00 EDT"
a3="09:30:00 EDT"
a4="10:00:00 EDT"

echo "<!DOCTYPE html>
<html>
<head>
<title>CCN alert E-mail</title>
<style>
table{width: 100%;}
td, th {
    border: 1px solid #dddddd;
    font-family: arial, sans-serif;
    border-collapse: collapse;
    text-align: left;
    padding: 8px;
}


</style>
</head>
<body>

<h1 align=center><u>Arrival status of files</u></h1>
<br>
<p><b>Check Type:</b> File/Feed monitoring(8:35 AM, 9:35 AM, 10:05 AM EST)</p>
<p><b>Server:</b> server</p>
<p><b>Path:</b> "$dir_path"</p>
<p><b>Below are the Status of files:</b></p>
<table>
  <tr>
    <th bgcolor=8a8a5c>Current Time</th>
    <th bgcolor=8a8a5c>Arrival Time</th>
    <th bgcolor=8a8a5c>File Name</th>
    <th bgcolor=8a8a5c>Remark</th>
  </tr>" > $script_dir/out.html

if [ $t -eq 0835 ]
then

                if [ -e "$dir_path/$f1" ]
                then
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a1"</td>
                                        <td>"$f1"</td>
                                        <td bgcolor=#00ff00>Has been received at `ls -ltr $dir_path | grep $f1 | awk '{print $6, $7, $8}'`</td>
                                        </tr>" > $script_dir/table.html
                else
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a1"</td>
                                        <td>"$f1"</td>
                                        <td bgcolor=#ff0000>Not received yet, Please check</td>
                                        </tr>" > $script_dir/table.html
                fi


                if [ -e "$dir_path/$f2" ]
                then
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a2"</td>
                                        <td>"$f2"</td>
                                        <td bgcolor=#00ff00>Has been received at `ls -ltr $dir_path | grep $f2 | awk '{print $6, $7, $8}'`</td>
                                        </tr>" >> $script_dir/table.html
                else
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a2"</td>
                                        <td>"$f2"</td>
                                        <td bgcolor=#ff0000>Not received yet, Please check</td>
                                        </tr>" >> $script_dir/table.html
                fi
cat $script_dir/table.html >> $script_dir/out.html
elif [ $t -eq 0935 ]
then

                if [ -e "$dir_path/$f3" ]
                then
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a3"</td>
                                        <td>"$f3"</td>
                                        <td bgcolor=#00ff00>Has been received at `ls -ltr $dir_path | grep $f3 | awk '{print $6, $7, $8}'`</td>
                                        </tr>" >> $script_dir/table.html
                else
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a3"</td>
                                        <td>"$f3"</td>
                                        <td bgcolor=#ff0000>Not received yet, Please check</td>
                                        </tr>" >> $script_dir/table.html
                fi
cat $script_dir/table.html >> $script_dir/out.html
elif [ $t -eq 1005 ]
then

                if [ -e "$dir_path/$f4" ]
                then
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a4"</td>
                                        <td>"$f4"</td>
                                        <td bgcolor=#00ff00>Has been received at `ls -ltr $dir_path | grep $f4 | awk '{print $6, $7, $8}'`</td>
                                        </tr>" >> $script_dir/table.html
                else
                                echo    "<tr>
                                        <td>$d</td>
                                        <td>"$a4"</td>
                                        <td>"$f4"</td>
                                        <td bgcolor=#ff0000>Not received yet, Please check</td>
                                        </tr>" >> $script_dir/table.html
                fi
cat $script_dir/table.html >> $script_dir/out.html
rm $script_dir/table.html
fi

echo    "</table>
        </body>
        </html>" >> $script_dir/out.html

cat - $script_dir/out.html << EOF | /usr/sbin/sendmail -oi -t
From: 
To: 
Subject: Arrival status of files
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
EOF
rm $script_dir/out.html
