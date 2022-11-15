
--//[K2 GROUP]-READING---
select 
d.StudentNumber
,d.BuildingGrade as CurrentGrade
,EnglishLearner = case when d.EnglishLearner = 'N' then 'No' else 'Yes' end
,DisabilityCondition = case when d.DisabilityCondition = '**' then 'No' else 'Yes' end
,d.DistrictAdmissionDate
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25))
,'KRA_LL' = (select coalesce(max(LangLitScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
--,'KRA_MA' = (select coalesce(max(MathScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
,'KRA_OVERALL' = (select coalesce(max(OverallScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
,i.Test_Date
,'Term' = case when (Test_Date between '2022-08-01' and '2023-01-03') then 'Fall'
			when (Test_Date between '2022-05-09' and '2022-05-31') then 'Spring'
			when (Test_Date between '2022-01-03' and '2022-05-08') then 'Winter'
			when (Test_Date between '2021-08-01' and '2022-01-03') then 'Fall'
		else '' end
,i.Scale_Score
,i.Percentile
,i.Grade
,i.Typical_Growth
,i.Stretch_Growth
,'TotalMin' = (select coalesce(sum(Min_per_Lesson),0) from iReady_Reading_Pers p where d.StudentNumber=p.StudentID)
,i.Subject
from Default_StudentRoster d
inner join iready_diag_agg_ela i on d.StudentNumber=i.Student_ID
where BuildingGrade in ('KG','1','2') 
order by BuildingGrade, [Term];

--//[K2 GROUP]-MATH---
select 
d.StudentNumber
,d.BuildingGrade as CurrentGrade
,EnglishLearner = case when d.EnglishLearner = 'N' then 'No' else 'Yes' end
,DisabilityCondition = case when d.DisabilityCondition = '**' then 'No' else 'Yes' end
,d.DistrictAdmissionDate
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25))
--,'KRA_LL' = (select coalesce(max(LangLitScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
,'KRA_MA' = (select coalesce(max(MathScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
,'KRA_OVERALL' = (select coalesce(max(OverallScore),0) from KRA_TABLE k where d.StudentNumber=k.LocalID)
,i.Test_Date
,'Term' = case when (Test_Date between '2022-08-01' and '2023-01-03') then 'Fall'
			when (Test_Date between '2022-05-09' and '2022-05-31') then 'Spring'
			when (Test_Date between '2022-01-03' and '2022-05-08') then 'Winter'
			when (Test_Date between '2021-08-01' and '2022-01-03') then 'Fall'
		else '' end
,i.Scale_Score
,i.Percentile
,i.Grade
,i.Typical_Growth
,i.Stretch_Growth
,'TotalMin' = (select coalesce(sum(Min_per_Lesson),0) from iReady_Math_Pers p where d.StudentNumber=p.StudentID)
,i.Subject
from Default_StudentRoster d
inner join iready_diag_agg_math i on d.StudentNumber=i.Student_ID
where BuildingGrade in ('KG','1','2') 
order by BuildingGrade, [Term];

--//[38 GROUP]-READING---
select distinct
d.StudentNumber
,d.BuildingGrade as CurrentGrade
,EnglishLearner = case when d.EnglishLearner = 'N' then 'No' else 'Yes' end
,DisabilityCondition = case when d.DisabilityCondition = '**' then 'No' else 'Yes' end
,d.DistrictAdmissionDate
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25))
,i.Test_Date
,'Term' = case when (Test_Date between '2022-08-01' and '2023-01-03') then 'Fall'
			when (Test_Date between '2022-05-09' and '2022-05-31') then 'Spring'
			when (Test_Date between '2022-01-03' and '2022-05-08') then 'Winter'
			when (Test_Date between '2021-08-01' and '2022-01-03') then 'Fall'
		else '' end
,i.Scale_Score
,i.Percentile
,i.Grade
,i.Typical_Growth
,i.Stretch_Growth
,'TotalMin' = (select coalesce(sum(Min_per_Lesson),0) from iReady_Reading_Pers p where d.StudentNumber=p.StudentID)
,i.Subject
,o.TestName
,o.ProficiencyLevel
,o.ScaledScore
from Default_StudentRoster d
inner join iready_diag_agg_ela i on d.StudentNumber=i.Student_ID
inner join OST_EOC_Results o on d.StateStudentID=o.StateID
where BuildingGrade in ('3','4','5','6','7','8') and (o.TestName like '%english%' and o.TestTerm like '%Spring%')
order by BuildingGrade, [Term];


--//[38 GROUP]-MATH---
select distinct
d.StudentNumber
,d.BuildingGrade as CurrentGrade
,EnglishLearner = case when d.EnglishLearner = 'N' then 'No' else 'Yes' end
,DisabilityCondition = case when d.DisabilityCondition = '**' then 'No' else 'Yes' end
,d.DistrictAdmissionDate
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25))
,i.Test_Date
,'Term' = case when (Test_Date between '2022-08-01' and '2023-01-03') then 'Fall'
			when (Test_Date between '2022-05-09' and '2022-05-31') then 'Spring'
			when (Test_Date between '2022-01-03' and '2022-05-08') then 'Winter'
			when (Test_Date between '2021-08-01' and '2022-01-03') then 'Fall'
		else '' end
,i.Scale_Score
,i.Percentile
,i.Grade
,i.Typical_Growth
,i.Stretch_Growth
,'TotalMin' = (select coalesce(sum(Min_per_Lesson),0) from iReady_Math_Pers p where d.StudentNumber=p.StudentID)
,i.Subject
,o.TestName
,o.ProficiencyLevel
,o.ScaledScore
from Default_StudentRoster d
inner join iready_diag_agg_ela i on d.StudentNumber=i.Student_ID
inner join OST_EOC_Results o on d.StateStudentID=o.StateID
where BuildingGrade in ('3','4','5','6','7','8') and ((o.TestName like '%mathematics%' or o.TestName like '%algebra%') and o.TestTerm like '%Spring%')
order by BuildingGrade, [Term];

--//[910 GROUP]-READING---
select distinct 
e.State_Student_ID
,'TestName' = 'English'
,e.Projected_State_Percentile
,'Percentile_Conv' = case when e.Projected_State_Percentile <=20 then 1
			when e.Projected_State_Percentile between 21 and 40 then 2
			when e.Projected_State_Percentile between 41 and 60 then 3
			when e.Projected_State_Percentile between 61 and 80 then 4
			when e.Projected_State_Percentile  >=81 then 5
		else 0 end
,o.TestName
,o.ProficiencyLevel as EOC_Level
,o.ScaledScore as EOC_Score
,'Diagnostic1' = (select max(Diagnostic_Overall_Scale_Score_1) from district.dbo.iReady_diagnostic_ela_ytd  i where d.StudentNumber=i.Student_ID) 
,'Diagnostic2' = (select max(Diagnostic_Overall_Scale_Score_2) from district.dbo.iReady_diagnostic_ela_ytd  i where d.StudentNumber=i.Student_ID) 
,'Diagnostic3' = (select max(Diagnostic_Overall_Scale_Score_Most_Recent) from district.dbo.iReady_diagnostic_ela_ytd  i where d.StudentNumber=i.Student_ID)
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25) from district.dbo.Default_StudentRoster r where r.StateStudentID=e.State_Student_ID)
from [EVAAS_2022_Student_Projections] e
left join OST_EOC_Results o on e.State_Student_ID=o.StateID
left join HighSchool.dbo.Demographics d on e.State_Student_ID=d.StateStudentID
where e.Grade_Attributed in ('9','10') and e.Projection like '%arts ii%' 
and o.TestName like '%arts 2%'


--//[910 GROUP]-MATH---
select distinct 
e.State_Student_ID
,'TestName' = 'Algebra I'
,e.Projected_State_Percentile as EVAAS_Proj
,'Percentile_Conv' = case when e.Projected_State_Percentile <=20 then 1
			when e.Projected_State_Percentile between 21 and 40 then 2
			when e.Projected_State_Percentile between 41 and 60 then 3
			when e.Projected_State_Percentile between 61 and 80 then 4
			when e.Projected_State_Percentile  >=81 then 5
		else 0 end
,o.TestName
,o.ProficiencyLevel as EOC_Level
,o.ScaledScore as EOC_Score
,'Diagnostic1' = (select max(Diagnostic_Overall_Scale_Score_1) from district.dbo.iReady_diagnostic_math_ytd  i where d.StudentNumber=i.Student_ID) 
,'Diagnostic2' = (select max(Diagnostic_Overall_Scale_Score_2) from district.dbo.iReady_diagnostic_math_ytd  i where d.StudentNumber=i.Student_ID) 
,'Diagnostic3' = (select max(Diagnostic_Overall_Scale_Score_Most_Recent) from district.dbo.iReady_diagnostic_math_ytd  i where d.StudentNumber=i.Student_ID) 
,'YearsinDistrict' = (SELECT (DATEDIFF(DAY, DistrictAdmissionDate, CURRENT_TIMESTAMP) / 365.25) from district.dbo.Default_StudentRoster r where r.StateStudentID=e.State_Student_ID)
from [EVAAS_2023_Student_Projections] e
left join OST_EOC_Results o on e.State_Student_ID=o.StateID
left join HighSchool.dbo.Demographics d on e.State_Student_ID=d.StateStudentID
where e.Grade_Attributed in ('9','10') and e.Projection like '%algebra%'
and o.TestName like '%algebra%'

