-- 'Continuous' updates
SELECT cron.schedule('*/5 * * * *', '-- 5min. update senders + receivers
    SELECT update_receivers();
    SELECT update_senders();
    SELECT update_receiver_countries();
');
SELECT cron.schedule('*/10 * * * *', '-- 10min. plausibilisation
    SELECT update_plausibilities(
		(NOW()-INTERVAL''16 minutes'')::TIMESTAMP, 
		(NOW()-INTERVAL''5 minutes'')::TIMESTAMP
	);
');
SELECT cron.schedule('*/5 * * * *', 'REFRESH MATERIALIZED VIEW senders_joined;');
SELECT cron.schedule('*/5 * * * *', 'REFRESH MATERIALIZED VIEW receivers_joined;');
SELECT cron.schedule('*/5 * * * *', 'REFRESH MATERIALIZED VIEW ranking;');

-- 'Hourly' updates
SELECT cron.schedule('5 * * * *', 'SELECT update_confirmations();');

-- 'Daily' updates
SELECT cron.schedule('10 0 * * *', 'REFRESH MATERIALIZED VIEW senders_relative_qualities;');
