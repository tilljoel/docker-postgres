echo 'allow full access - start'

set -x
sed -i "/^#listen_addresses/i listen_addresses='*'" /data/postgresql.conf
sed -i "/^# DO NOT DISABLE\!/i # Allow access from any IP address" /data/pg_hba.conf
sed -i "/^# DO NOT DISABLE\!/i host all all 0.0.0.0/0 md5\n\n\n" /data/pg_hba.conf

echo 'allow full access - done'
