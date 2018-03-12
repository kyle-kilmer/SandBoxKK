--Table entry Updates

-- Changs to paragraphs ot mitigating factors
update tblMitigatingFactorQuestions
set Literal = 'If this crime has not been committed in a manner to make it an ‘armed felony’ (see CPL 1.20[41] and Penal Law 10.00[12]), then youthful offender treatment is allowed. If this crime has been committed in a manner to make it an ''armed felony'' (see CPL 1.20[41] and Penal Law 10.00[12]), then youthful offender treatment is allowed only if the court determines that a mitigating factor exists.  CPL 720.10(2) and (3).  Continue as a youthful offender? '
where Short = 'Armed Felony';
update tblMitigatingFactorQuestions
set Literal = 'Youthful offender treatment is allowed for this crime only if the court determines that a mitigating factor exists.  CPL 720.10(2) and (3).  Continue as a youthful offender?'
where Short = 'Youthful Offender';


-- Deleting "violent felony" mitigating factor
delete from tblCrimesMitigatingFactorQuestions where MitigatingFactorQuestionsID = 3;
delete from tblMitigatingFactorQuestions where MitigatingFactorQuestionsID = 3 and Short='Violent Felony';


--Deleting qualifying Questions with ID 7 and 8
DELETE FROM tblQuestions where QuestionsID = 7;
DELETE FROM tblQuestions where QuestionsID = 8;