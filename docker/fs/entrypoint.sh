#!/bin/bash
# Copyright 2021-2024 FLECS Technologies GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ -n "$FTP_USER" ] && [ -z "$FTP_PASSWORD" ]; then
    echo "Environment variable FTP_USER is set but FTP_PASSWORD is not set or empty, either both or neither have to be set."
    exit 1
fi
if [ -z "$FTP_USER" ] && [ -n "$FTP_PASSWORD" ]; then
    echo "Environment variable FTP_PASSWORD is set but FTP_USER is not set or empty, either both or neither have to be set."
    exit 1
fi

if [ -n "$FTP_USER" ] && [ -n "$FTP_PASSWORD" ]; then
    echo "Using virtual user $FTP_USER (from environment variable FTP_USER) and password from environment variable FTP_PASSWORD."
    printf "$FTP_USER\n$FTP_PASSWORD\n" > /etc/vsftpd/vusers.tmp.txt
else
    echo "Using virtual users from file /etc/vsftpd/vusers.txt"
    cp /etc/vsftpd/vusers.txt /etc/vsftpd/vusers.tmp.txt
fi

db_load -T -t hash -f /etc/vsftpd/vusers.tmp.txt /etc/vsftpd/vsftpd-virtual-user.db
chmod 600 /etc/vsftpd/vsftpd-virtual-user.db
rm /etc/vsftpd/vusers.tmp.txt

exec vsftpd "$@"