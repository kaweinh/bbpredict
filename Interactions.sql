SELECT d.DisplayId as EmployeeId, b.CourseNumber as Course, c.SourceKey as TermSourceKey, a.WeekNumber, 
	a.TotalInteractions, a.TotalMinutes
	
FROM iBBLA.[Final].ReportingFactCourseActivity a

INNER JOIN iBBLA.[Final].DimCourse b on a.CourseKey=b.CourseKey
INNER JOIN iBBLA.[Final].DimTerm c on a.TermKey=c.TermKey
INNER JOIN iBBLA.[Final].DimUser d on a.UserKey=d.UserKey

WHERE c.SourceKey IN ('2172', '2178', '2182', '2188', '2192', '2198')
	AND d.InstitutionRoleDescription = 'Student';
	

