DROP TABLE IF EXISTS LOG;
DROP TABLE IF EXISTS STUDENT;
DROP SEQUENCE IF EXISTS LogIdSeq;

CREATE TABLE STUDENT
(
    StudentId INT PRIMARY KEY,
    Surname NVARCHAR(MAX),
    Givename NVARCHAR(MAX),
    Mobile INT
);

CREATE TABLE LOG
(
    LogId INT PRIMARY KEY,
    StudentId INT,
    DateTimeChanged DATE,
    DBUser NVARCHAR(MAX),
    OldSurname NVARCHAR(MAX) NULL,
    NewSurname NVARCHAR(MAX),
    OldGivenName NVARCHAR(MAX) NULL,
    NewGivenName NVARCHAR(MAX),
    OldMobile INT NULL,
    NewMobile INT,
    FOREIGN KEY (StudentId) REFERENCES STUDENT
     
);

CREATE SEQUENCE LogIdSeq
    START WITH 1
    INCREMENT BY 1;
GO


/*
    Trigger 1

*/

CREATE TRIGGER TR_Insert
ON STUDENT
FOR INSERT
AS

BEGIN
    INSERT INTO LOG (LogId, StudentId, DateTimeChanged, DBUser, OldSurname, NewSurname, OldGivenName, NewGivenName, OldMobile, NewMobile)
    SELECT NEXT VALUE FOR LogIdSeq, i.StudentId, GETDATE(), USER_NAME(), NULL, i.Surname, NULL, i.Givename, NULL, i.Mobile
    FROM inserted i
END
GO


SELECT * FROM STUDENT;
SELECT * FROM LOG;

INSERT INTO STUDENT(StudentId, Surname, Givename, Mobile)
VALUES(1214, 'Johnson', 'Cave', 1234890)
INSERT INTO STUDENT(StudentId, Surname, Givename, Mobile)
VALUES(1215, 'Johnson', 'Cave', 1234899)
INSERT INTO STUDENT(StudentId, Surname, Givename, Mobile)
VALUES(1216, 'Johnson', 'Cave', 1234898)

SELECT * FROM STUDENT;
SELECT * FROM LOG;
GO

/*
    Trigger 2

*/

CREATE TRIGGER TR_Update
ON STUDENT
FOR UPDATE
AS

BEGIN
    INSERT INTO LOG (LogId, StudentId, DateTimeChanged, DBUser, OldSurname, NewSurname, OldGivenName, NewGivenName, OldMobile, NewMobile)
    SELECT NEXT VALUE FOR LogIdSeq, i.StudentId, GETDATE(), USER_NAME(), d.Surname, i.Surname, d.Givename, i.Givename, d.Mobile, i.Mobile
    FROM deleted d, inserted i
END
GO

UPDATE STUDENT
SET Surname = 'Johnny', Givename = 'John', Mobile =10249421
WHERE StudentId = 1214

SELECT * FROM STUDENT;
SELECT * FROM LOG;
GO



/*
    Trigger 3

*/
CREATE TRIGGER TR_Delete
ON STUDENT
INSTEAD OF DELETE
AS

BEGIN
    SELECT 'Students cannot Be Deleted' as [Message]
END
GO

SELECT * FROM STUDENT;


DELETE FROM STUDENT
WHERE StudentId = 1214

SELECT * FROM STUDENT;
SELECT * FROM LOG;
