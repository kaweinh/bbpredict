SELECT d.SISSourceKey as EmployeeID, b.CourseNumber as Course, c.SourceKey as TermSourceKey, 
AVG(a.Grade) as GradePercentage, COUNT(a.PossibleScore) as TotalAssignments

FROM iBBLA.[Final].FactGradeCenter a

INNER JOIN iBBLA.[Final].DimCourse b on a.CourseKey=b.CourseKey
INNER JOIN iBBLA.[Final].DimTerm c on a.TermKey=c.TermKey
INNER JOIN iBBLA.[Final].DimStudent d on a.StudentKey=d.StudentKey

WHERE c.SourceKey IN ('2172', '2178', '2182', '2188', '2192', '2198') 
	AND d.SISSourceKey != 'Unkown' 
	AND ((a.LastGradedDate > '2019-08-01' AND a.LastGradedDate < '2019-09-23') 
		OR (a.LastGradedDate > '2018-08-01' AND a.LastGradedDate < '2018-09-24')
		OR (a.LastGradedDate > '2017-08-01' AND a.LastGradedDate < '2017-09-25') 
		OR (a.LastGradedDate > '2019-01-01' AND a.LastGradedDate < '2019-02-18') 
		OR (a.LastGradedDate > '2018-01-01' AND a.LastGradedDate < '2018-02-19') 
		OR (a.LastGradedDate > '2017-01-01' AND a.LastGradedDate < '2017-02-20')) 

GROUP BY d.SISSourceKey, b.CourseNumber, c.SourceKey;