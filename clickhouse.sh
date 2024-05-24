docker rm -f clickhouse-server
docker run -d -p 8123:8123 \
    --restart unless-stopped \
    -v /Users/francesco/Documents/Development/traintech/data/ch_data/:/var/lib/clickhouse/ \
    -v /Users/francesco/Documents/Development/traintech/data/ch_logs:/var/log/clickhouse-server/ \
    --name clickhouse-server --ulimit nofile=262144:262144 clickhouse/clickhouse-server
exit 0

DROP DATABASE traintech;
CREATE DATABASE traintech;
CREATE TABLE IF NOT EXISTS traintech.measurements (
    timestamp UInt64 DEFAULT toUnixTimestamp64Milli(now64(3)),
    station_id Int8,
    ) ENGINE = MergeTree()
ORDER BY (timestamp,station_id)
PRIMARY KEY (timestamp);

insert into traintech.measurements (station) values (1);
select * from traintech.measurements
