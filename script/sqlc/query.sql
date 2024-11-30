-- name: FindTopPlayerPoint :many
SELECT
    *
FROM
    users
ORDER BY
    points DESC
LIMIT
    ? OFFSET ?;

-- name: FindLatestCompletionWithTrackAndStyle :many
SELECT
    pt.map,
    pt.track,
    pt.style,
    pt.time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
FROM
    playertimes pt
    JOIN users u ON pt.auth = u.auth
WHERE
    pt.track = ?
    AND pt.style = ?
GROUP BY
    pt.map,
    pt.track,
    pt.style,
    pt.time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
ORDER BY
    pt.date DESC
LIMIT
    ? OFFSET ?;

-- name: FindLatestCompletion :many
SELECT
    pt.map,
    pt.track,
    pt.style,
    pt.time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
FROM
    playertimes pt
    JOIN users u ON pt.auth = u.auth
GROUP BY
    pt.map,
    pt.track,
    pt.style,
    pt.time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
ORDER BY
    pt.date DESC
LIMIT
    ? OFFSET ?;

-- name: FindLatestWrWithTrackAndStyle :many
SELECT
    pt.map,
    pt.track,
    pt.style,
    MIN(pt.time) AS min_time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
FROM
    playertimes pt
    JOIN users u ON pt.auth = u.auth
WHERE
    pt.time = (
        SELECT
            MIN(pt2.time)
        FROM
            playertimes pt2
        WHERE
            pt2.map = pt.map
            AND pt2.track = pt.track
            AND pt2.style = pt.style
    )
    AND pt.track = ?
    AND pt.style = ?
GROUP BY
    pt.map,
    pt.track,
    pt.style,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
ORDER BY
    pt.date DESC
LIMIT
    ? OFFSET ?;

-- name: FindLatestWr :many
SELECT
    pt.map,
    pt.track,
    pt.style,
    MIN(pt.time) AS min_time,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
FROM
    playertimes pt
    JOIN users u ON pt.auth = u.auth
WHERE
    pt.time = (
        SELECT
            MIN(pt2.time)
        FROM
            playertimes pt2
        WHERE
            pt2.map = pt.map
            AND pt2.track = pt.track
            AND pt2.style = pt.style
    )
GROUP BY
    pt.map,
    pt.track,
    pt.style,
    u.name,
    u.ip,
    u.lastlogin,
    pt.date,
    pt.points,
    pt.jumps,
    pt.strafes,
    pt.sync,
    pt.perfs,
    pt.completions
ORDER BY
    pt.date DESC
LIMIT
    ? OFFSET ?;