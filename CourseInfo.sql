SELECT ClassNumberUniqueDescription as Course, TermSourceKey,
	COUNT(*) as CourseSize 

FROM iPSSA.UMBC.ReportFactRegistration

WHERE TermSourceKey IN (2172, 2178, 2182, 2188, 2192, 2198)
	AND GradedComponentIndicatorKey = 2
	AND DropCount = 0
	AND VersionKey = 1
	AND CareerKey = 3
	AND GradeSourceKey IN ('A','B','C','D','F','W')

GROUP BY ClassNumberUniqueDescription, TermSourceKey

ORDER BY CourseSize DESC;

