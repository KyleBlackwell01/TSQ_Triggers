DROP TABLE IF EXISTS LOG 
DROP TABLE IF EXISTS STUDENT 

CREATE TABLE STUDENT
(
    StudentId INT PRIMARY KEY,
    Surname NVARCHAR,
    Givename NVARCHAR,
    Mobile INT
);

CREATE TABLE LOG
(
    LogId INT PRIMARY KEY,
    StudentId INT,
    DateTimeChanged DATE,
    DBUser NVARCHAR,
    OldSurname NVARCHAR NULL,
    NewSurname NVARCHAR,
    OldGivenName NVARCHAR NULL,
    NewGivenName NVARCHAR,
    OldMobile INT NULL,
    NewMobile INT,
    FOREIGN KEY (StudentId) REFERENCES STUDENT
     
);

CREATE SEQUENCE LogIdSeq;

Drop TRIGGER TR_INSERT

CREATE TRIGGER TR_Insert
ON Student
FOR INSERT
AS

BEGIN
    INSERT INTO LOG (LogId, StudentId, DateTimeChanged, DBUser, OldSurname, NewSurname, OldGivenName, NewGivenName, OldMobile, NewMobile)
    SELECT 123, i.StudentId, GETDATE(), USER_NAME(), NULL, i.Surname, NULL, i.Givename, NULL, i.Mobile
    FROM inserted i
END
GO


SELECT * FROM STUDENT;
SELECT * FROM LOG;

INSERT INTO STUDENT(StudentId, Surname, Givename, Mobile)
VALUES(10241024, 'Johnson', 'Cave', 1234890);

SELECT * FROM STUDENT;
SELECT * FROM LOG;
