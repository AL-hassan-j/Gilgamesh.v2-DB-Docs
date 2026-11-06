SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_ADD_NEW_USER] 
@Public_ID CHAR(10),
@FullName NVARCHAR(50),
@Gender VARCHAR(10),
@DateOfBirth DATE,
@UserName NVARCHAR(100),
@Avatar  NVARCHAR(300) NULL,
@Bio NVARCHAR(250) NULL,
@Email NVARCHAR(100),
@PasswordHash  VARCHAR(256)

AS 
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY 

            BEGIN TRANSACTION 


                IF EXISTS( SELECT 1 FROM Users WHERE Email = @Email) -- 1. التحقق من تكرار الإيميل
                    THROW 50001, N'Email already exists', 1;


                IF NOT @Email LIKE '%@%.%' -- 2. التحقق من صحة صيغة الإيميل
                    THROW 50002, N'Email Invalid Format', 2;


                IF EXISTS( SELECT 1 FROM Users WHERE UserName = @UserName) -- 3. التحقق من تكرار اسم المستخدم
                    THROW 50003, N'UserName already exists', 3;
            
                IF @DateOfBirth > DATEADD(YEAR, -15, CONVERT(DATE, GETDATE())) -- 4. التحقق من العمر اكبر من او يساوي 15
                    THROW 50004, 'User must be at least 15 years old', 4;


                DECLARE @PersonID INT; 

                INSERT INTO Persons (FullName, Gender, DateOfBirth) 
                VALUES( @FullName, @Gender, @DateOfBirth);

                SET @PersonID = SCOPE_IDENTITY();

                INSERT INTO Users (Public_ID, Person_ID, UserName, Bio, Avatar,  Email, PasswordHash)
                VALUES (@Public_ID, @PersonID, @UserName, @Bio, @Avatar, @Email, @PasswordHash)


                SELECT 
                Public_ID,
                FullName,
                Gender,
                DateOfBirth,
                UserName,
                Avatar,
                Bio,
                Email
                FROM 
                Users u INNER JOIN Persons p ON
                u.Person_ID = p.Person_ID WHERE p.Person_ID = @PersonID;

            COMMIT TRANSACTION
    
    END TRY 

   
    BEGIN CATCH

        IF @@TRANCOUNT > 0

            BEGIN 
                ROLLBACK  TRANSACTION;
            END;

        THROW;
    END CATCH

END
GO
