-- Fix syntax error in objects-prefixes permissions
DO $$
    DECLARE
        anon_role text = COALESCE(current_setting('storage.anon_role', true), 'anon');
        authenticated_role text = COALESCE(current_setting('storage.authenticated_role', true), 'authenticated');
        service_role text = COALESCE(current_setting('storage.service_role', true), 'service_role');
    BEGIN
        EXECUTE 'GRANT ALL ON TABLE storage.prefixes TO ' || service_role || ', ' || authenticated_role || ', ' || anon_role;
END$$; 