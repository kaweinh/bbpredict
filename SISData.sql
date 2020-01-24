SELECT 
	a.EmployeeID, a.TermSourceKey, a.TermKey, a.StudentKey,
	a.HighSchoolGPA,
	a.SATMathScore, a.SATReadingWritingScore, a.SATMathOldScore, a.SATWritingOldScore, a.SATReadingOldScore,
	a.ACTCompositeScore,
	a.SourceAge, a.GenderDescription, a.EthnicityDescription,
	a.MajorDescription,
	a.MilitaryStatusKey, a.FirstGenerationKey,
	a.CumulativeTransferCredits, a.TransferGPA,
	a.CumulativeGPA, a.CumulativeCreditsAttempted, a.CumulativeCreditsEarned,
	a.AcademicLevelDescription, a.AcademicLoadTuitionDescription, a.WithdrawCount,
	b.PellEligibilityIndicatorKey,
	
	c.ClassNumberUniqueDescription AS Course, 
	c.ClassNumberCourseLevel AS CourseLevel,
	c.ClassNumberClassSectionSourceKey AS Section,
	c.GradeSourceKey AS Grade,
	
	prev.TermCreditsAttempted AS PrevTermCreditsAttempted, 
	prev.TermCreditsEarned AS PrevTermCreditsEarned,
	prev.TermGPA AS PrevTermGPA,
	prev.MaxGrade AS PrevMaxGrade, prev.MinGrade AS PrevMinGrade
	
	--b.ClassNumberUniqueDescription AS Course,
	--b.GradeDescription AS Grade

FROM iPSSA.UMBC.ReportFactRegistration c

INNER JOIN 
	(
		SELECT 
			a.StudentKey, a.TermSourceKey, b.NextTermSourceKey,
			a.TermCreditsAttempted, a.TermCreditsEarned, a.TermGPA,
			Max(d.GradePoints) as MaxGrade, Min(d.GradePoints) as MinGrade
		
		FROM iPSSA.UMBC.ReportFactStudentTerm a
		
		INNER JOIN iPSSA.[Final].DimTerm b on a.TermKey = b.TermKey
		
		INNER JOIN iPSSA.UMBC.ReportFactRegistration c ON a.EmployeeID = c.EmployeeID
			AND a.TermSourceKey = c.TermSourceKey
			AND a.PrimaryStudentTermIndicatorKey = 2
			--AND a.VersionKey = 4
			--AND a.CareerKey = 3
			AND a.DegreeSeekingIndicatorKey = 2
			
		INNER JOIN iPSSA.[Final].DimGrade d on c.GradeKey = d.GradeKey
			
		WHERE a.TermSourceKey IN ('2168', '2172', '2178', '2182', '2188', '2192')
			AND c.GradedComponentIndicatorKey = 2
			--AND c.DropCount = 0
			--AND c.VersionKey = 1
			--AND c.CareerKey = 3
			AND c.GradeSourceKey IN ('A','B','C','D','F','W')
			AND a.HasTermGPA = 1
		
		GROUP BY a.StudentKey, a.TermSourceKey, b.NextTermSourceKey,
			a.TermCreditsAttempted, a.TermCreditsEarned, a.TermGPA
	) prev on (prev.StudentKey = c.StudentKey and prev.NextTermSourceKey = c.TermSourceKey)
	
INNER JOIN iPSSA.UMBC.ReportFactStudentTerm a ON a.EmployeeID = c.EmployeeID
	AND a.TermSourceKey = c.TermSourceKey
	AND a.PrimaryStudentTermIndicatorKey = 2
	AND a.VersionKey = 4
	AND a.CareerKey = 3
	AND a.DegreeSeekingIndicatorKey = 2

LEFT JOIN iPSSA.[Final].FactFinancialAidStudentTerm b ON a.EmployeeID = b.EmployeeID
	AND a.TermSourceKey = b.TermSourceKey
	AND b.VersionKey = 1
	
WHERE c.TermSourceKey IN (2172, 2178, 2182, 2188, 2192, 2198)
	AND c.GradedComponentIndicatorKey = 2
	AND c.DropCount = 0
	AND c.VersionKey = 1
	AND c.CareerKey = 3
	AND c.GradeSourceKey IN ('A','B','C','D','F','W');