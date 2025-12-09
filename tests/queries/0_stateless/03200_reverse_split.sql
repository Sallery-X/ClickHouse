-- Test basic functionality
SELECT reverseSplit('www.google.com');
SELECT reverseSplit('a/b/c', '/');
SELECT reverseSplit('x::y::z', '::');
SELECT reverseSplit('a..b', '.');
SELECT reverseSplit('.a.b.', '.');
SELECT reverseSplit('single');
SELECT reverseSplit('');
SELECT reverseSplit('a/b/c', '');

-- Test with column input
SELECT reverseSplit(domain) FROM (SELECT arrayJoin(['www.google.com', 'mail.yahoo.com', 'clickhouse.com']) AS domain);

-- Test with constant separator column
SELECT reverseSplit(domain, sep) FROM (
    SELECT 
        arrayJoin(['www.google.com', 'user@example.com', 'path/to/file']) AS domain,
        arrayJoin(['.', '@', '/']) AS sep
);

-- Edge cases
SELECT reverseSplit('...', '.');
SELECT reverseSplit('a.b.c', 'x');
SELECT reverseSplit(materialize('www.example.com'));
SELECT reverseSplit(materialize('www.example.com'), materialize('.'));

-- NULL handling
SELECT reverseSplit(NULL);
SELECT reverseSplit(NULL, '.');
SELECT reverseSplit(NULL, NULL);
SELECT reverseSplit('test', NULL);

-- Empty and special cases
SELECT reverseSplit('abc', 'abc');
SELECT reverseSplit('abcabc', 'abc');
SELECT reverseSplit('test', '');
SELECT reverseSplit('', '.');

-- Multi-character separators
SELECT reverseSplit('one::two::three', '::');
SELECT reverseSplit('start--middle--end', '--');
SELECT reverseSplit('a|||b|||c', '|||');

-- Performance test with repeated patterns
SELECT reverseSplit('a.b.c.d.e.f.g.h.i.j');
SELECT reverseSplit('1/2/3/4/5/6/7/8/9/10', '/');